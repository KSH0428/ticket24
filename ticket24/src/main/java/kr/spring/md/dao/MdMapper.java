package kr.spring.md.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.md.vo.MdVO;

@Mapper
public interface MdMapper {
	
	//상품리스트
	public List<MdVO> selectList(Map<String,Object> map);
	public int selectRowCount(Map<String,Object> map);
	//상품 등록
	public void insertMd(MdVO md);
	//상품 상세
	public MdVO selectMd(int md_num);
	//상품 수정
	public void updateMd(MdVO md);
	//상품 삭제
	@Delete("DELETE FROM md WHERE md_num=#{md_num}")
	public void deleteMd(int md_num);
	//상품 이미지 수정
	//@Update("UPDATE md SET photo1='',photo2='' WHERE md_num=#{md_num}")
	public void deleteFile(int md_num);

}
