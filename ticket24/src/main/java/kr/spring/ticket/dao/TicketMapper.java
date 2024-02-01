package kr.spring.ticket.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Update;

import kr.spring.ticket.vo.TicketVO;

@Mapper
public interface TicketMapper {
	public List<TicketVO> selectList(Map<String,Object> map);
	public int selectRowCount(Map<String,Object> map);
	public void insertTicket(TicketVO ticket);
	public TicketVO selectTicket(int ticket_num);
	@Update("UPDATE ticket SET ticket_hit=ticket_hit+1 WHERE ticket_num=#{ticket_num}")
	public void updateTicket_hit(int ticket_num);
	public void updateTicket(TicketVO ticket);
	@Delete("DELETE FROM ticket WHERE ticket_num=#{ticket_num}")
	public void deleteTicket(int ticket_num);
	@Update("UPDATE ticket SET ticket_filename1='',ticket_filename2='',ticket_filename3='',ticket_filename4='' WHERE ticket_num=#{ticket_num}")
	public void deleteFile(int ticket_num);
		
}


