package kr.spring.musical.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.classic.dao.ClassicMapper;
import kr.spring.classic.vo.ClassicVO;
import kr.spring.concert.vo.ConcertVO;
import kr.spring.musical.dao.MusicalMapper;
import kr.spring.musical.vo.MusicalVO;

@Service
@Transactional
public class MusicalServiceImpl implements MusicalService {
	@Autowired
	private MusicalMapper musicalMapper;

	@Override
	public void insertMusical(MusicalVO musical) {
		musicalMapper.insertMusical(musical);
	}
	
	/* --------웹크롤링-------- */
	@Override
	public int selectRowCount(Map<String, Object> map) {
		return musicalMapper.selectRowCount(map);
	}

	@Override
	public List<MusicalVO> selectList(Map<String, Object> map) {
		return musicalMapper.selectList(map);
	}
}
