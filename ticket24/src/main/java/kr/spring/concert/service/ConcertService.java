package kr.spring.concert.service;

import kr.spring.concert.vo.ConcertDetailVO;
import kr.spring.concert.vo.ConcertVO;

public interface ConcertService {
	//콘서트 리스트
		public void insertConcert(ConcertVO concert);
		
		//콘서트 상세
		public void insertConcertDetail(ConcertDetailVO concertdetail);
}
