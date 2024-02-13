package kr.spring.classic.service;

import java.util.List;
import java.util.Map;

import kr.spring.classic.vo.ClassicVO;

public interface ClassicService {
	
	//클래식
	public int selectRowCount(Map<String,Object> map);
	public List<ClassicVO> selectList(Map<String,Object> map);
	//-----------웹 크롤링-------------
	
	//클래식 리스트
	public void insertClassic(ClassicVO classic);
}
