package kr.spring.md.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Update;

import kr.spring.md.vo.MdVO;

@Mapper
public interface MdMapper {
	public List<MdVO> selectList(Map<String,Object> map);
	public int selectRowCount(Map<String,Object> map);
	public void insertMd(MdVO md);
	 public MdVO selectMd(int md_num);
	 @Update("UPDATE md SET hit=hit+1 WHERE md_num=#{md_num}")
	 public void updateHit(int md_num);
	 public void updateMd(MdVO md);
	 @Delete("DELETE FROM md WHERE md_num=#{md_num}")
	 public void deleteMd(int md_num);
	 public void deleteFile(int md_num);

}
