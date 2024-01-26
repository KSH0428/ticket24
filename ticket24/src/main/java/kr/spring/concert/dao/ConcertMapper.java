package kr.spring.concert.dao;

import org.apache.ibatis.annotations.Mapper;

import kr.spring.concert.vo.ConcertDetailVO;
import kr.spring.concert.vo.ConcertVO;

@Mapper
public interface ConcertMapper {
	//콘서트 리스트
	public void insertConcert(ConcertVO concert);
	
	//콘서트 상세
	public void insertConcertDetail(ConcertDetailVO concertdetail);
}
