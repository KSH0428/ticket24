package kr.spring.md.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.md.dao.MdMapper;
import kr.spring.md.vo.MdVO;

@Service
@Transactional
public class MdServiceImpl implements MdService{
	
	@Autowired
	private MdMapper mdMapper;

	@Override
	public List<MdVO> selectList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int selectRowCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public void insertMd(MdVO md) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public MdVO selectMd(int md_num) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateHit(int md_num) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateMd(MdVO md) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteMd(int md_num) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteFile(int md_num) {
		// TODO Auto-generated method stub
		
	}
	
	
	
	
	

}
