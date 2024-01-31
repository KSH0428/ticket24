package kr.spring.ticket.service;

import java.util.List;
import java.util.Map;

import kr.spring.ticket.vo.TicketVO;

public interface TicketService {
	//티켓 양도글
	public List<TicketVO> selectList(Map<String,Object> map);
	public int SelectRowCount(Map<String,Object> map);
	public void insertTicket(TicketVO ticket);
	public TicketVO selectTicket(int ticket_num);
	public void updateTicket(TicketVO ticket);
	public void deleteTicket(int ticket_num);
	public void deleteFile(int ticket_num);
	
}


