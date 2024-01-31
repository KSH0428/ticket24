package kr.spring.ticket.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.member.vo.MemberVO;
import kr.spring.ticket.service.TicketService;
import kr.spring.ticket.vo.TicketVO;
import kr.spring.util.FileUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class TicketAjaxController {
	@Autowired
	private TicketService ticketService;
	/*==============================
	 * 부모글 업로드 파일 삭제
	 *=============================*/
	@RequestMapping("ticket/deleteFile")
	@ResponseBody
	public Map<String,String> processFile(int ticket_num, HttpSession session, HttpServletRequest request){
		
		Map<String,String> mapJson = new HashMap<String,String>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user==null) {
			mapJson.put("result", "logout");
		}else {
			TicketVO vo = ticketService.selectTicket(ticket_num);
			
			ticketService.deleteFile(ticket_num);
			FileUtil.removeFile(request, vo.getTicket_filename1());
			FileUtil.removeFile(request, vo.getTicket_filename2());
			FileUtil.removeFile(request, vo.getTicket_filename3());
			FileUtil.removeFile(request, vo.getTicket_filename4());
			
			mapJson.put("result", "success");
		}
		
		return mapJson;
	}
}
