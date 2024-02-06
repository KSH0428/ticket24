package kr.spring.ticketpay.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.ticket.vo.TicketVO;
import kr.spring.ticketpay.dao.TicketPayMapper;
import kr.spring.ticketpay.vo.TicketPayVO;

@Service
@Transactional
public class TicketPayServiceImpl implements TicketPayService {

	@Override
	public void insertTicketPay(TicketPayVO ticketPayVO) {
		
		
	}

	@Override
	public List<TicketVO> getReservHistory(int mem_num) {
		// TODO Auto-generated method stub
		return null;
	}



}
