package kr.spring.ticketpay.service;

import java.util.List;

import kr.spring.ticket.vo.TicketVO;
import kr.spring.ticketpay.vo.TicketPayVO;

public interface TicketPayService {
    // 티켓 결제 정보 등록
    public void insertTicketPay(TicketPayVO ticketPayVO);
    // 예약 내역 조회
    public List<TicketVO> getReservHistory(int mem_num);
}

