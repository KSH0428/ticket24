package kr.spring.reserv.service;

import java.sql.Date;
import java.util.List;


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
}
