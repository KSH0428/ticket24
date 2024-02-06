package kr.spring.concert.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.concert.dao.ConcertMapper;
import kr.spring.concert.vo.ConcertDetailVO;
import kr.spring.concert.vo.ConcertRoundVO;
import kr.spring.concert.vo.ConcertVO;

@Service
@Transactional
public class ConsertServiceImpl implements ConcertService{
	@Autowired
	private ConcertMapper concertMapper;
	
	//-------------------------------
	// 웹 크롤링 시작
	//-------------------------------

	@Override
	public void insertConcert(ConcertVO concert) {
		concertMapper.insertConcert(concert);

	}

	@Override
	public void insertConcertDetail(ConcertDetailVO concertdetail) {
		concertMapper.insertConcertDetail(concertdetail);
	}

	@Override
	public void insertConcertRound(ConcertRoundVO round) {
		concertMapper.insertConcertRound(round);

	}



	//-------------------------------
	// 웹 크롤링 끝
	//-------------------------------
	
	@Override
	public List<ConcertVO> selectList(Map<String, Object> map) {
		return concertMapper.selectList(map);
	}

	@Override
	public int selectRowCount(Map<String, Object> map) {
		return concertMapper.selectRowCount(map);
	}
	
	@Override
	public ConcertDetailVO selectConcert(int concert_num) {
		return concertMapper.selectConcert(concert_num);
	}
	
	@Override
	public List<ConcertRoundVO> selectRoundList(int concert_num) {
		return concertMapper.selectRoundList(concert_num);
	}

	@Override
	public int selectC_roundRemainingSeats(int c_round_num) {
		return concertMapper.selectC_roundRemainingSeats(c_round_num);
	}

	@Override
	public ConcertVO selectConcertInfo(int concert_num) {
		return concertMapper.selectConcertInfo(concert_num);
	}

	@Override
	public ConcertRoundVO selectRound(int c_round_num) {
		return concertMapper.selectRound(c_round_num);
	}
	
	




}
