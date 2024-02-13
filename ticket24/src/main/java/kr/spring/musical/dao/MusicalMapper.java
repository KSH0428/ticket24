package kr.spring.musical.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.spring.musical.vo.MusicalVO;

@Mapper
public interface MusicalMapper {
	
	//클래식
	public int selectRowCount(Map<String,Object> map);
	public List<MusicalVO> selectList(Map<String,Object> map);
	//-----------웹 크롤링-------------
	
	//클래식 리스트
	public void insertMusical(MusicalVO musical);
}
