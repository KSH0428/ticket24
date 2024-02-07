package kr.spring.ticketpay.controller;

import java.io.IOException;

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

import kr.spring.member.vo.MemberVO;
import kr.spring.ticketpay.service.TicketPayService;
import kr.spring.ticketpay.vo.TicketPayVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class TicketPayController {
	@Autowired
	private TicketPayService ticketPayService;
	
	/*=======================================
	 * 구매 정보 등록
	 *======================================*/
	//자바빈(VO)초기화
	@ModelAttribute
	public TicketPayVO initCommand() {
		return new TicketPayVO();
	}
	//등록 폼 호출
	@GetMapping("/ticketPay/write")
	public String form() {
		return "ticketPay/ticketPayWrite";
	}
	//전송된 데이터 처리
	@PostMapping("/ticketPay/write")
	public String submit(@Valid TicketPayVO ticketPayVO, BindingResult result,
						 HttpServletRequest request,
						 HttpSession session, Model model) throws IllegalStateException, IOException {
		log.debug("<<티켓양도 글 저장>> : " + ticketPayVO);
		
		//회원번호 셋팅
		MemberVO vo = (MemberVO)session.getAttribute("user");
		ticketPayVO.setMem_num(vo.getMem_num());
		
		log.debug("<<티켓양도 글 저장>> : " + ticketPayVO);
		//유효성 체크 결과 오류가 있으면 폼 호출
		if(result.hasErrors()) {
			return form();
		}
		
		//글쓰기
		ticketPayService.insertTicketPay(ticketPayVO);
		
		//View에 표시할 메시지
		model.addAttribute("message", "정보등록이 완료되었습니다.");
		model.addAttribute("url",request.getContextPath()+"/ticketPay/list");
		
		return "common/resultAlert";
	}
}
