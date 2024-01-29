package kr.spring.concert.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.concert.dao.ConcertMapper;
import kr.spring.concert.vo.ConcertDetailVO;
import kr.spring.concert.vo.ConcertVO;

@Service
@Transactional
public class ConsertServiceImpl implements ConcertService{
	@Autowired
	private ConcertMapper concertMapper;
	
	@Override
	public List<ConcertVO> selectList(Map<String, Object> map) {
		return concertMapper.selectList(map);
	}

	@Override
	public int selectRowCount(Map<String, Object> map) {
		return concertMapper.selectRowCount(map);
	}
	
	//-------------------------------
	// 웹 크롤링
	//-------------------------------
	
	@Override
	public void insertConcert(ConcertVO concert) {
		concertMapper.insertConcert(concert);
		
	}

	@Override
	public void insertConcertDetail(ConcertDetailVO concertdetail) {
		concertMapper.insertConcertDetail(concertdetail);
	}




}
