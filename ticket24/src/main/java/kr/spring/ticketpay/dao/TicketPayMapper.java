package kr.spring.ticketpay.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.spring.ticket.vo.TicketVO;
import kr.spring.ticketpay.vo.TicketPayVO;

@Mapper
public interface TicketPayMapper {
	// 티켓 결제 정보 등록
    public void insertTicketPay(TicketPayVO ticketPay);
    //예약 내역 개수
    public int selectRowCount(Map<String,Object> map);
    // 예약 내역 조회
    public List<TicketPayVO> selectReservList(Map<String,Object> map);
    //예약 내역 상세
    public TicketPayVO selectTicketPay(int ticket_num);
    
    
}


