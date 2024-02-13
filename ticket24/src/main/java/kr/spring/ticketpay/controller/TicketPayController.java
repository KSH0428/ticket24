package kr.spring.ticketpay.controller;

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
import kr.spring.ticket.vo.TicketVO;
import kr.spring.ticketpay.service.TicketPayService;
import kr.spring.ticketpay.vo.TicketPayVO;
import kr.spring.util.PageUtil;
import kr.spring.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class TicketPayController {
	@Autowired
	private TicketPayService ticketPayService;
	
	/*=======================================
	 * 구매 정보 등록
	 *======================================*/
	//등록 폼 호출
	@GetMapping("/ticketPay/write")
	public String form(TicketPayVO vo) {
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
			return "ticketPay/ticketPayWrite";
		}
		
		//글쓰기
		ticketPayService.insertTicketPay(ticketPayVO);
		
		//View에 표시할 메시지
		model.addAttribute("message", "정보등록이 완료되었습니다.");
		model.addAttribute("url",request.getContextPath()+"/ticketPay/list");
		
		return "common/resultAlert";
	}
	/*=======================================
	 * 예약 목록
	 *======================================*/
	@RequestMapping("/ticketPay/list")
	public ModelAndView process (@RequestParam(value="pageNum",defaultValue="1")int currentPage,
			@RequestParam(value="order",defaultValue="1") int order,String keyfield, String keyword,HttpSession session) {
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		map.put("mem_num", user.getMem_num());
		
		//전체/검색 레코드 수
		int count = ticketPayService.selectRowCount(map);
		log.debug("<<count>> : " + count);
		
		PageUtil page = new PageUtil(keyfield,keyword,currentPage,count,20,10,"list");
		
		List<TicketPayVO> list = null;

		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = ticketPayService.selectReservList(map);
			log.debug("<<list>> : " + list);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("ticketPayList");
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		
		return mav;
	}
	/*=======================================
	 * 게시판 글 상세
	 *======================================*/
	@RequestMapping("/ticketPay/detail")
	public ModelAndView process(@RequestParam int ticket_num) {
		log.debug("<<예약 상세 ticket_num>> : " + ticket_num);
		
		 TicketVO ticket = ticketPayService.selectTicketPay(ticket_num);
		
		//제목에 태그를 허용하지 않음
		ticket.setTicket_name(StringUtil.useNoHtml(ticket.getTicket_name()));
		
		//타일스 설정명,   속성명,    속성값
		return new ModelAndView("ticketPayView", "ticket", ticket);
	}

}
