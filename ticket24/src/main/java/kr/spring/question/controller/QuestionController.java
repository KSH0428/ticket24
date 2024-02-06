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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.spring.member.vo.MemberVO;
import kr.spring.question.dao.QuestionMapper;
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
	public String submit(@Valid QuestionVO questionVO, BindingResult result,
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
						@RequestParam(defaultValue="0") int question_category, 
						String keyfield, String keyword) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		map.put("question_category", question_category);
		
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
	 * 문의글 진입 페이지
	 *=====================*/	
	//해당 문의글의 글 번호 불러오기
	@GetMapping("/question/checkPassword")
	public String formCheck(@RequestParam int question_num, Model model) {
		QuestionVO questionVO = questionService.selectQuestion(question_num);
		model.addAttribute("questionVO", questionVO);
		
		return "checkPassword";
	}
	
	@PostMapping("/question/checkPassword")
	public String submitCheck(@RequestParam int question_num,
							  @RequestParam String question_passwd,
							  HttpServletRequest request,
							  QuestionVO questionVO, Model model) {
		
		QuestionVO db_question = questionService.selectQuestion(questionVO.getQuestion_num());
		
	    if (db_question != null && question_passwd.equals(db_question.getQuestion_passwd())) {
	        // 비밀번호 일치 시 상세 페이지로 리다이렉트
	    	model.addAttribute("question_num", question_num);
	        return "redirect:/question/detail?question_num=" + question_num;
	    } else {
	    	model.addAttribute("message", "비밀번호 불일치");
	    	model.addAttribute("url", request.getContextPath() + "/question/checkPassword?question_num=" + question_num);
	    	
	    	return "common/resultAlert";
	    }
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
	@RequestMapping("/question/file")
	public ModelAndView download(@RequestParam int question_num, HttpServletRequest request) {
		QuestionVO question = questionService.selectQuestion(question_num);
		
		//파일을 절대경로에서 읽어들여 byte[]로 변환
		byte[] downloadFile = FileUtil.getBytes(
				request.getServletContext().getRealPath("/upload")
				+"/"+question.getQuestion_photo());
		ModelAndView mav = new ModelAndView();
		mav.setViewName("downloadView");
		mav.addObject("downloadFile", downloadFile);
		mav.addObject("filename", question.getQuestion_photo());

		return mav;
		
	}
	
	/*=====================
	 * 문의글 수정
	 *=====================*/
	//수정 폼 호출
	@GetMapping("/question/update")
	public String formUpdate(@RequestParam int question_num, Model model) {
		QuestionVO questionVO = questionService.selectQuestion(question_num);
		
		model.addAttribute("questionVO", questionVO);
		
		return "questionModify";
	}
	//수정폼에서 전송된 데이터 처리
	@PostMapping("/question/update")
	public String subminUpdate(@Valid QuestionVO questionVO, BindingResult result,
								HttpServletRequest request, Model model) throws IllegalStateException, IOException {
		log.debug("<<문의글 수정>> : " + questionVO);
		
		//유효성 체크 결과 오류가 있으면 폼 호출
		if(result.hasErrors()) {
			//title 또는 content가 입력되지 않아 유효성 체크에 걸리면
			//파일 정보를 잃어버리기 때문에 폼을 호출할 때 다시 셋팅해주어야 함
			QuestionVO vo = questionService.selectQuestion(questionVO.getQuestion_num());
			questionVO.setQuestion_photo(vo.getQuestion_photo());
			return "questionModify";
		}
		
		//DB에 저장된 파일 정보 구하기
		QuestionVO db_question = questionService.selectQuestion(questionVO.getQuestion_num());
		//파일명 셋팅
		questionVO.setQuestion_photo(FileUtil.createFile(request, questionVO.getUpload()));
		//ip 셋팅
		questionVO.setQuestion_ip(request.getRemoteAddr());
		
		//글 수정
		questionService.updateQuestion(questionVO);
		
		//전송된 파일이 있을 경우 이전 파일 삭제
		if(questionVO.getUpload() != null && !questionVO.getUpload().isEmpty()) {
			//수정 전 파일 삭제 처리
			FileUtil.removeFile(request, db_question.getQuestion_photo());
		}
		
		model.addAttribute("message", "글 수정 완료!");
		model.addAttribute("url", request.getContextPath() + "/question/detail?question_num=" + questionVO.getQuestion_num());
		
		return "common/resultAlert";
	}
	
	/*=====================
	 * 문의글 답변 수정(관리자)
	 *=====================*/
	@GetMapping("/question/adminUpdate")
	public String formAdminUpdate(@RequestParam int question_num, Model model) {
		QuestionVO questionVO = questionService.selectQuestion(question_num);
		model.addAttribute("questionVO", questionVO);
	    
		return "adminQuestionModify";
	}

	@PostMapping("/question/adminUpdate")
	public String submitAdminUpdate(QuestionVO questionVO, HttpServletRequest request, Model model) {
	    log.debug("<<문의글 답변 수정>> : " + questionVO);

	    questionVO.setQuestion_ip(request.getRemoteAddr());
	    questionService.updateAnswer(questionVO);
	    
	    model.addAttribute("message", "글 수정 완료!");
	    // 수정된 답변이 속한 질문글의 상세 페이지로 이동
	    model.addAttribute("url", request.getContextPath() + "/question/list");

	    return "common/resultAlert";
	}

	/*=====================
	 * 문의글 삭제
	 *=====================*/
	//문의글 삭제하면 답변글도 삭제
	@RequestMapping("/question/delete")
	public String submitDelete(@RequestParam int question_num, HttpServletRequest request, Model model) {
		log.debug("<<문의글 삭제 question_num>> : " + question_num);
		
		//DB에 저장된 파일 정보 구하기
		QuestionVO db_question = questionService.selectQuestion(question_num);
		
		//답변글 삭제
		questionService.deleteQuestion(question_num);
		//문의글 삭제
		questionService.deleteAnswer(question_num);
		//파일 삭제
		if(db_question.getQuestion_photo() != null) {
			FileUtil.removeFile(request, db_question.getQuestion_photo());
		}
		
		model.addAttribute("message", "삭제 완료!");
		model.addAttribute("url", request.getContextPath() + "/question/list");

		return "common/resultAlert";
	}
	
	
	/*=====================
	 * 답변글 삭제
	 *=====================*/
	@RequestMapping("/question/adminDelete")
	public String submitAdminDelete(@RequestParam int question_num, HttpServletRequest request, Model model) {
		log.debug("<<답변글 삭제 question_renum>> : " + question_num);
		
		//답변글 삭제
		questionService.deleteAnswer(question_num);
		
		model.addAttribute("message", "삭제 완료!");
		model.addAttribute("url", request.getContextPath() + "/question/detail?question_num=" + question_num);

		return "common/resultAlert";
	}
	
}
