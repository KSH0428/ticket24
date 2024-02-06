package kr.spring.concert.service;

import java.util.List;
import java.util.Map;

import kr.spring.concert.vo.ConcertDetailVO;
import kr.spring.concert.vo.ConcertRoundVO;
import kr.spring.concert.vo.ConcertVO;

public interface ConcertService {
	//콘서트 

	public int selectRowCount(Map<String,Object> map);
	public List<ConcertVO> selectList(Map<String,Object> map);
	
	//콘서트 상세
	public ConcertDetailVO selectConcert(int concert_num);
	
	//콘서트 회차
	public List<ConcertRoundVO> selectRoundList(int concert_num);
	
	//콘서트 회차 좌석 정보
	public int selectC_roundRemainingSeats(int c_round_num);
	
	//단일 콘서트 정보
	public ConcertVO selectConcertInfo(int concert_num);
	
	//단일 콘서트 회차 정보
	public ConcertRoundVO selectRound(int c_round_num);
	//--------------웹 스크롤 -----------------

	//콘서트 리스트
	public void insertConcert(ConcertVO concert);

	//콘서트 상세
	public void insertConcertDetail(ConcertDetailVO concertdetail);
	
	//콘서트 회차
	public void insertConcertRound(ConcertRoundVO round);
}
