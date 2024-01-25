package kr.spring.md.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;

import kr.spring.md.vo.MdVO;

public interface AdminMdService{
	public List<MdVO> selectList(Map<String,Object> map);
	public int selectRowCount(Map<String,Object> map);
	public void insertMd(MdVO md);
	public MdVO selectMd(int md_num);
	public void updateMd(MdVO md);
	public void deleteMd(int md_num);
	public void deleteFile(int md_num);
}
