package kr.spring.concert.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import kr.spring.concert.vo.ConcertDetailVO;
import kr.spring.concert.vo.ConcertRoundVO;
import kr.spring.concert.vo.ConcertSeatVO;
import kr.spring.concert.vo.ConcertVO;

@Mapper
public interface ConcertMapper {
	//콘서트 

	public int selectRowCount(Map<String,Object> map);
	public List<ConcertVO> selectList(Map<String,Object> map);
	public ConcertDetailVO selectConcert(int concert_num);
	
	//콘서트 회차
	public List<ConcertRoundVO> selectRoundList(int concert_num);
	public int selectC_roundRemainingSeats(int c_round_num);
	@Select("SELECT seat_num, status FROM concert_seat WHERE concert_num = #{concert_num} AND c_round_num = #{c_round_num}")
	public List<ConcertSeatVO> selectSeatsList(int concert_num, int c_round_num);
	
	//콘서트 상세 단독
	public ConcertVO selectConcertInfo(int concert_num);
	
	//콘서트 회차 단독
	public ConcertRoundVO selectRound(int c_round_num);
	
	//--------------포인트 조회-----------------
	@Select("SELECT NVL(SUM(pt_amount),0) AS pt_sum FROM member_point WHERE mem_num=#{mem_num}")
	public int searchUserPoint(int mem_num);
	//--------------웹 크롤링 -----------------

	//콘서트 리스트
	public void insertConcert(ConcertVO concert);

	//콘서트 상세 페이지
	public void insertConcertDetail(ConcertDetailVO concertdetail);
	
	//콘서트 회차
	public void insertConcertRound(ConcertRoundVO round);
	
	//콘서트 좌석 초기화
	@Insert("INSERT INTO concert_seat (concert_num,c_round_num,seat_num) VALUES(#{num},#{round_num},#{i})")
	public void initializeSeat(int i, int num, int round_num);
}
