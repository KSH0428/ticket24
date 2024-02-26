package kr.spring.musical.service;

import java.util.List;
import java.util.Map;

import kr.spring.musical.vo.MusicalVO;

public interface MusicalService {
	
	//클래식
	public int selectRowCount(Map<String,Object> map);
	public List<MusicalVO> selectList(Map<String,Object> map);
	//-----------웹 크롤링-------------
	
	//클래식 리스트
	public void insertMusical(MusicalVO musical);
}
