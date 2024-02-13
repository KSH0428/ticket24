package kr.spring.ticketpay.service;

import java.util.List;
import java.util.Map;

import kr.spring.ticket.vo.TicketVO;
import kr.spring.ticketpay.vo.TicketPayVO;

public interface TicketPayService {
    // 티켓 결제 정보 등록
    public void insertTicketPay(TicketPayVO ticketPay);
    //예약 목록 개수
    public int selectRowCount(Map<String,Object> map);
    // 예약 내역 조회
    public List<TicketPayVO> selectReservList(Map<String,Object> map);
    //예약 내역 상세
    public TicketVO selectTicketPay(int ticket_num);
    
    // 티켓 번호 반환 (결제하기 숨기기)
    public TicketPayVO reservTicketPay(int ticket_num);
}



