package kr.spring.classic.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.classic.dao.ClassicMapper;
import kr.spring.classic.vo.ClassicVO;
import kr.spring.concert.vo.ConcertVO;

@Service
@Transactional
public class ClassicServiceImpl implements ClassicService {
	@Autowired
	private ClassicMapper classicMapper;

	@Override
	public void insertClassic(ClassicVO classic) {
		classicMapper.insertClassic(classic);
	}
	
	/* --------웹크롤링-------- */
	@Override
	public int selectRowCount(Map<String, Object> map) {
		return classicMapper.selectRowCount(map);
	}

	@Override
	public List<ClassicVO> selectList(Map<String, Object> map) {
		return classicMapper.selectList(map);
	}
}
