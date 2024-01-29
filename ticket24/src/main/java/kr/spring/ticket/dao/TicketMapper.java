package kr.spring.ticket.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Update;

import kr.spring.ticket.vo.TicketVO;

public interface TicketMapper {
	public  List<TicketVO> selectList(Map<String,Object> map);
	public int selectRowCount(Map<String,Object> map);
	public void insertTicket(TicketVO ticket);
	public void updateTicket(TicketVO ticket);
	@Delete("DELETE FROM ticket WHERE ticket_num=#{ticket_num}")
	public void deleteTicket(int ticket_num);
	//@Update("UPDATE ticket SET ticket_filename='' WHERE ticket_num=#{ticket_num}")
	// = 여러개?
	public void deleteFile(int ticket_num);
		
}
