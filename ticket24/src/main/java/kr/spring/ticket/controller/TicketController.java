package kr.spring.ticket.controller;

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

import kr.spring.ticket.service.TicketService;
import kr.spring.ticket.vo.TicketVO;
import kr.spring.util.FileUtil;
import kr.spring.util.PageUtil;
import kr.spring.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class TicketController {
	@Autowired
	private TicketService ticketService;
	
	/*=======================================
	 * 게시판 글 등록
	 *======================================*/
	//자바빈(VO)초기화
	@ModelAttribute
	public TicketVO initCommand() {
		return new TicketVO();
	}
	//등록 폼 호출
	@GetMapping("/ticket/write")
	public String form() {
		return "ticketWrite";
	}
	
	//전송된 데이터 처리
	@PostMapping("/ticket/write")
	public String submit(@Valid TicketVO ticketVO, BindingResult result,
						  HttpServletRequest request,
						  HttpSession session, Model model) throws IllegalStateException, IOException {
		log.debug("<<티켓양도 글 저장>> : " + ticketVO);
		
		//유효성 체크 결과 오류가 있으면 폼 호출
		if(result.hasErrors()) {
			return form();
		}
		
		//파일업로드
		ticketVO.setTicket_filename1(FileUtil.createFile(request, ticketVO.getUpload()));
		ticketVO.setTicket_filename2(FileUtil.createFile(request, ticketVO.getUpload()));
		ticketVO.setTicket_filename3(FileUtil.createFile(request, ticketVO.getUpload()));
		ticketVO.setTicket_filename4(FileUtil.createFile(request, ticketVO.getUpload()));
		//글쓰기
		ticketService.insertTicket(ticketVO);
		
		//View에 표시할 메시지
		model.addAttribute("message", "상품등록이 완료되었습니다.");
		model.addAttribute("url",request.getContextPath()+"/ticket/list");
			
		return "common/resultAlert";
	}
	/*=======================================
	 * 게시판 글 목록
	 *======================================*/
	@RequestMapping("/ticket/list")
	public ModelAndView process(@RequestParam(value="pageNum",defaultValue="1")int currentPage,
								@RequestParam(value="order",defaultValue="1") int order,
								@RequestParam(value="ticket_category", defaultValue="") String ticket_category,
								String keyfield, String keyword) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyfield", keyword);
		map.put("keyword", keyword);
		map.put("ticket_category", ticket_category);
		
		//전체/검색 레코드 수
		int count = ticketService.SelectRowCount(map);
		log.debug("<<count>> : " + count);
		
		PageUtil page = new PageUtil(keyfield,keyword,currentPage,count,20,10,"list", "&order="+order+"&ticket_category="+ticket_category);
		
		List<TicketVO> list = null;
		if(count > 0) {
			map.put("order", order);
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = ticketService.selectList(map);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("ticketList");
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		
		return mav;
	}
	/*=======================================
	 * 게시판 글 상세
	 *======================================*/
	@RequestMapping("/ticket/detail")
	public ModelAndView process(@RequestParam int ticket_num) {
		log.debug("<<티켓양도 글 상세 ticket_num>> : " + ticket_num);
		
		TicketVO ticket = ticketService.selectTicket(ticket_num);
		//제목에 태그를 허용하지 않음
		ticket.setTicket_name(StringUtil.useNoHtml(ticket.getTicket_name()));
								//타일스 설정명,   속성명,    속성값
		return new ModelAndView("ticketView", "ticket", ticket);
	}

}
