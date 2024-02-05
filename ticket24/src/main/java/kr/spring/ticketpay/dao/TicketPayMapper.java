package kr.spring.ticketpay.dao;

import org.apache.ibatis.annotations.Mapper;

import kr.spring.ticketpay.vo.TicketPayVO;

@Mapper
public interface TicketPayMapper {
	 // 티켓 결제 정보 등록
    public void insertTicketPayment(TicketPayVO ticketPayVO);
}
