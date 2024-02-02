package kr.spring.ticket.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.ticket.dao.TicketMapper;
import kr.spring.ticket.vo.TicketVO;

@Service
@Transactional
public class TicketServiceImpl implements TicketService {
	@Autowired
	private TicketMapper ticketMapper;
	@Override
	public List<TicketVO> selectList(Map<String, Object> map) {
		return ticketMapper.selectList(map);
	}

	@Override
	public int selectRowCount(Map<String, Object> map) {
		return ticketMapper.selectRowCount(map);
	}

	@Override
	public void insertTicket(TicketVO ticket) {
		ticketMapper.insertTicket(ticket);
		
	}

	@Override
	public TicketVO selectTicket(int ticket_num) {
		return ticketMapper.selectTicket(ticket_num);
	}
	
	@Override
	public void updateTicket_hit(int ticket_num) {
		ticketMapper.updateTicket_hit(ticket_num);
		
	}
	
	@Override
	public void updateTicket(TicketVO ticket) {
		ticketMapper.updateTicket(ticket);
		
	}

	@Override
	public void deleteTicket(int ticket_num) {
		ticketMapper.deleteTicket(ticket_num);
		
	}

	@Override
	public void deleteFile(int ticket_num) {
		ticketMapper.deleteFile(ticket_num);
		
	}
	

}

