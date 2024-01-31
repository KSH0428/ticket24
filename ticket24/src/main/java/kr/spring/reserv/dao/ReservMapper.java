package kr.spring.reserv.dao;

import java.sql.Date;
import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import kr.spring.reserv.vo.ReservHallDateVO;
import kr.spring.reserv.vo.ReservHallVO;

@Mapper
public interface ReservMapper {
	//대관 예약
	public void insertReserv(ReservHallVO reservHallVO);
	//대관 날짜 예약
	@Insert("INSERT INTO reservhalldate VALUES (#{reservation_num},#{reservation_date})")
	public void insertReservDate(ReservHallDateVO reservHallVO);
	//대관 번호 받기
	@Select("SELECT reserv_seq.nextval FROM dual")
	public int selectReservNum();
	//예약된 전체 날짜 조회
	@Select("SELECT reservation_date FROM reservhalldate")
	public List<String> selectReservDate();
	
	//멤버로 예약기록 조회
	@Select("SELECT * FROM reservhall WHERE mem_num=#{mem_num}")
	public List<ReservHallVO> selectReservList(int mem_num);
	//예약번호로 예약 날짜 조회
	@Select("SELECT reservation_date FROM reservhalldate WHERE reservation_num=#{reservation_num}")
	public List<Date> selectReservDateList(int reservation_num);
	//예약번호로 예약 내역 조회
	@Select("SELECT * FROM reservhall WHERE reservation_num=#{reservation_num}")
	public ReservHallVO selectReservListByReservNum(int reservation_num);
	
	
	
}