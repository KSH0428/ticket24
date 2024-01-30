package kr.spring.concert.service;

import java.util.List;
import java.util.Map;

import kr.spring.concert.vo.ConcertDetailVO;
import kr.spring.concert.vo.ConcertVO;

public interface ConcertService {
	//콘서트 

	public int selectRowCount(Map<String,Object> map);
	public List<ConcertVO> selectList(Map<String,Object> map);
	
	//콘서트 상세
	public ConcertDetailVO selectConcert(int concert_num);
	
	//--------------웹 스크롤 -----------------

	//콘서트 리스트 읽어오기
	public void insertConcert(ConcertVO concert);

	//콘서트 상세 페이지 읽어오기
	public void insertConcertDetail(ConcertDetailVO concertdetail);
}
