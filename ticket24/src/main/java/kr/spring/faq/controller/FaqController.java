package kr.spring.faq.controller;

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

import kr.spring.faq.service.FaqService;
import kr.spring.faq.vo.FaqVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.util.PageUtil;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class FaqController {
	@Autowired
	private FaqService faqService;
	
	/*=====================
	 * 질문 등록
	 *=====================*/
	//자바빈(VO) 초기화
	@ModelAttribute
	public FaqVO initCommand() {
		return new FaqVO();
	}
	
	//등록 폼 호출
	@GetMapping("/faq/write")
	public String form() {
		return "faqWrite";
	}
	
	//전송된 데이터 처리
	@PostMapping("/faq/write")
	public String submit(@Valid FaqVO faqVO, BindingResult result,
						 HttpServletRequest request, HttpSession session, Model model) {
		log.debug("<<질문 등록>> : " + faqVO);
		
		//유효성 체크 결과 오류가 있으면 폼 호출
		if(result.hasErrors()) {
			return form();
		}
		
		faqService.insertFaq(faqVO);
		
		//View에 표시할 메시지
		model.addAttribute("message", "등록되었습니다.");
		model.addAttribute("url", request.getContextPath()+"/faq/list");

		return "common/resultAlert";
	}
	
	/*=====================
	 * 질문 리스트
	 *=====================*/
	@RequestMapping("/faq/list")
	public ModelAndView process(String keyword, HttpSession session, 
								@RequestParam(value="pageNum", defaultValue="1") int currentPage,
								@RequestParam (defaultValue = "0") int faq_category) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyword", keyword);
		map.put("faq_category", faq_category);
		
		int count = faqService.selectRowCount(map);
		
		PageUtil page = new PageUtil(null,null,currentPage,count,10,10,"list");
		
		
		List<FaqVO> list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			list = faqService.selectFaqList(map);
		}

		MemberVO user = (MemberVO)session.getAttribute("user");
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("faqList");
		mav.addObject("list", list);
		mav.addObject("user", user);
		mav.addObject("count", count);
		mav.addObject("page", page.getPage());
		
		return mav;
	}
	
	/*=====================
	 * 질문 수정
	 *=====================*/
	//수정 폼 호출
	@GetMapping("/faq/update")
	public String formUpdate(@RequestParam int faq_num, Model model) {
		FaqVO faqVO = faqService.selectFaq(faq_num);
		
		model.addAttribute("faqVO", faqVO);
		
		return "faqModify";
	}
	
	//수정폼에서 전송된 데이터 처리
	@PostMapping("/faq/update")
	public String submitUpdate(@Valid FaqVO faqVO, BindingResult result,
							   HttpServletRequest request, Model model) {
		//유효성 체크 결과 오류가 있으면 폼 호출
		if(result.hasErrors()) {
			return "faqModify";
		}
		
		//글 수정
		faqService.updateFaq(faqVO);
		
		model.addAttribute("message", "수정 완료!");
		model.addAttribute("url", request.getContextPath() + "/faq/list");
		
		return "common/resultAlert";
	}
	
	/*=====================
	 * 질문 삭제
	 *=====================*/
	@RequestMapping("/faq/delete")
	public String submitDelete(@RequestParam int faq_num, HttpServletRequest request, Model model) {
		log.debug("<<질문 삭제 faq_num>> : " + faq_num);
		
		//글 삭제
		faqService.deleteFaq(faq_num);
		
		model.addAttribute("message", "삭제 완료!");
		model.addAttribute("url", request.getContextPath() + "/faq/list");

		return "common/resultAlert";
	}
	
}
