package kr.spring.concert.service;

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
	public void insertConcert(ConcertVO concert) {
		concertMapper.insertConcert(concert);
		
	}

	@Override
	public void insertConcertDetail(ConcertDetailVO concertdetail) {
		concertMapper.insertConcertDetail(concertdetail);
	}

}
