package kr.spring.md.service;

import java.util.List;
import java.util.Map;

import kr.spring.md.vo.MdVO;

public interface MdService {
	//부모글
		public List<MdVO> selectList(Map<String,Object> map);
		public int selectRowCount(Map<String,Object> map);
		public void insertMd(MdVO md);
		public MdVO selectMd(int md_num); 
		public void updateHit(int md_num);
		public void updateMd(MdVO md);
		public void deleteMd(int md_num);
		public void deleteFile(int md_num);
			
	
	
}
