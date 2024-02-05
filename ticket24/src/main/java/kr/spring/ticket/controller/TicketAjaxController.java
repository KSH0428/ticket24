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
	public Map<String,String> processFile(int ticket_num, int file_num, HttpSession session, HttpServletRequest request){
		
		Map<String,String> mapJson = new HashMap<String,String>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user==null) {
			mapJson.put("result", "logout");
		}else {
			TicketVO vo = ticketService.selectTicket(ticket_num);
			
			Map<String,Integer> map = new HashMap<String,Integer>();
			map.put("ticket_num", ticket_num);
			map.put("file_num", file_num);
			
			ticketService.deleteFile(map);
			if(file_num==1) {
				FileUtil.removeFile(request, vo.getTicket_filename1());
			}
			if(file_num==2) {
				FileUtil.removeFile(request, vo.getTicket_filename2());
			}
			
			if(file_num==3) {
				FileUtil.removeFile(request, vo.getTicket_filename3());
			}
			if(file_num==4) {
				FileUtil.removeFile(request, vo.getTicket_filename4());
			}
			mapJson.put("result", "success");
		}
		
		return mapJson;
	}
}


