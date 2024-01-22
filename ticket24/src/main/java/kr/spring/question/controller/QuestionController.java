package kr.spring.question.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.member.vo.MemberVO;
import kr.spring.question.service.QuestionService;
import kr.spring.question.vo.QuestionVO;
import kr.spring.util.FileUtil;
import kr.spring.util.PageUtil;
import kr.spring.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class QuestionController {
	@Autowired
	private QuestionService questionService;
	
	/*=====================
	 * 문의글 등록(회원)
	 *=====================*/
	//자바빈(VO) 초기화
	@ModelAttribute
	public QuestionVO initCommand() {
		return new QuestionVO();
	}
	
	//등록 폼 호출
	@GetMapping("/question/write")
	public String form() {
		return "questionWrite";
	}
	
	//전송된 데이터 처리
	@PostMapping("/question/write")
	public String submit(QuestionVO questionVO, BindingResult result,
						 HttpServletRequest request, HttpSession session, Model model) throws IllegalStateException, IOException {
		log.debug("<<1:1 문의글 저장>> : " + questionVO);
		
		//유효성 체크 결과 오류가 있으면 폼 호출
		if(result.hasErrors()) {
			return form();
		}
		
		//회원번호 셋팅
		MemberVO vo = (MemberVO)session.getAttribute("user");
		questionVO.setMem_num(vo.getMem_num());
		//문의글 레벨 1로 셋팅
		questionVO.setQuestion_level(1);
		//ip 셋팅
		questionVO.setQuestion_ip(request.getRemoteAddr());
		//파일 업로드
		questionVO.setQuestion_photo(FileUtil.createFile(request, questionVO.getUpload()));
		//글 쓰기
	    questionService.insertQuestion(questionVO);
	    
	    //View에 표시할 메시지
		model.addAttribute("message", "글쓰기가 완료되었습니다.");
		model.addAttribute("url", request.getContextPath()+"/question/list");
	    
		return "common/resultAlert";
	}
	
	/*=====================
	 * 문의글 답변 등록(관리자)
	 *=====================*/
	// 등록 폼 호출
	@GetMapping("/question/adminWrite")
	public String formAdmin(@RequestParam int question_num, Model model) {
	    
	    QuestionVO question = questionService.selectQuestion(question_num);
	    model.addAttribute("question", question);
	    
	    return "adminQuestionWrite";
	}

	// 전송된 데이터 처리
	@PostMapping("/question/adminWrite")
	public String submitAdmin(@RequestParam int question_num,
	                          @Valid QuestionVO questionVO, BindingResult result,
	                          HttpServletRequest request, HttpSession session, Model model) {
	    log.debug("<<문의글 번호>> : " + question_num);
	    log.debug("<<문의글 답변 저장>> : " + questionVO);

	    // 유효성 체크 결과 오류가 있으면 폼 호출
	    if (result.hasErrors()) {
	        return formAdmin(question_num, model);
	    }

	    // 원글 정보 조회
	    QuestionVO user_question = questionService.selectQuestion(question_num);
	    MemberVO member = (MemberVO)session.getAttribute("user");
	    
	    questionVO.setMem_num(member.getMem_num());
	    // 답변글 식별번호를 원글 번호와 동일하게 설정
	    questionVO.setQuestion_renum(user_question.getQuestion_num());
	    // 답변글 레벨 2로 셋팅
	    questionVO.setQuestion_level(2);
	    // 답변글 카테고리를 원글 카테고리와 동일하게 설정
	    questionVO.setQuestion_category(user_question.getQuestion_category());
	    // 답변글 비밀글 여부를 원글과 동일하게 설정
	    questionVO.setQuestion_lock(user_question.getQuestion_lock());
	    questionVO.setQuestion_passwd(user_question.getQuestion_passwd());
	    // IP 주소 설정
	    questionVO.setQuestion_ip(request.getRemoteAddr());

	    // 답변글 저장
	    questionService.insertQuestion(questionVO);

	    // View에 표시할 메시지
	    model.addAttribute("message", "답변이 등록되었습니다.");
	    model.addAttribute("url", request.getContextPath() + "/question/list");

	    return "common/resultAlert";
	}
	
	/*=====================
	 * 문의글 리스트
	 *=====================*/
	@RequestMapping("/question/list")
	public ModelAndView process(
						@RequestParam(value="pageNum",defaultValue="1") int currentPage,
						String keyfield, String keyword) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		//전체/검색 레코드수
		int count = questionService.selectRowCount(map);
		log.debug("<<count>> : " + count);
		
		PageUtil page = new PageUtil(keyfield, keyword, currentPage, count, 20, 10, "list");
		
		List<QuestionVO> list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = questionService.selectList(map);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("questionList");
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		
		return mav;
	}
	
	/*=====================
	 * 문의글 상세
	 *=====================*/
	@RequestMapping("/question/detail")
	public ModelAndView process(@RequestParam int question_num) {
	    log.debug("<<문의글 상세 question_num>> : " + question_num);

	    // 해당 글의 조회수 증가
	    questionService.updateHit(question_num);

	    // 질문글 조회
	    QuestionVO question = questionService.selectQuestion(question_num);
	    question.setQuestion_title(StringUtil.useNoHtml(question.getQuestion_title()));
	    
	    // 답변 조회 (question_renum이 같은 글만을 조회하도록 수정)
	    QuestionVO answer = questionService.selectAnswer(question_num);

	    ModelAndView mav = new ModelAndView("questionView");
	    mav.addObject("question", question);
	    mav.addObject("answer", answer);

	    return mav;
	}
	
	/*=====================
	 * 파일 다운로드
	 *=====================*/
	
	
	/*=====================
	 * 문의글 수정
	 *=====================*/
	
	
	/*=====================
	 * 문의글 답변 수정(관리자)
	 *=====================*/
	
	
	/*=====================
	 * 문의글,답변 삭제
	 *=====================*/
	
	
	
}
