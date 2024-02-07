package kr.spring.reserv.service;

import java.sql.Date;
import java.util.List;
import java.util.Map;


import kr.spring.reserv.vo.PaymentHallVO;
import kr.spring.reserv.vo.ReservHallDateVO;
import kr.spring.reserv.vo.ReservHallVO;

public interface ReservService {
	//대관 예약
	public void insertReserv(ReservHallVO reservHallVO);
	//예약된 전체 날짜 조회
	public List<String> selectReservDate();
	
	//멤버로 예약기록 조회
	public List<ReservHallVO> selectReservList(int mem_num);
	//예약번호로 예약 날짜 조회
	public List<Date> selectReservDateList(int reservation_num);
	
	//예약번호로 예약 내역 조회
	public ReservHallVO selectReservListByReservNum(int reservation_num);
	
	//신청취소
	public void deleteReservhall(int reservation_num);
	
	//관리자
	//전체 예약기록 조회
	public List<ReservHallVO> selectReservListAdmin(Map<String,Object> map);
	public int selectReservListAdminCount();
	//진행 상황 변경
	public void updateReservStatus(int reservation_num, int reservation_status);
	
	//결제
	//결제 테이블 생성
	public void insertPaymentHall(int reservation_num);
	//결제 테이블 조회
	public PaymentHallVO selectPaymentHall(int reservation_num);
	//결제완료
	public void updatePayment(PaymentHallVO paymentHallVO);
	
	//full calendar 일정 조회
	public List<ReservHallDateVO> selectReservSchedule ();
}
