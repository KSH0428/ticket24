package kr.spring.ticketpay.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.spring.ticket.vo.TicketVO;
import kr.spring.ticketpay.vo.TicketPayVO;

@Mapper
public interface TicketPayMapper {
	 // 티켓 결제 정보 등록
    public void insertTicketPayment(TicketPayVO ticketPayVO);
    // 예약 내역 조회
    public List<TicketVO> getReservHistory(int mem_num);
    
}
