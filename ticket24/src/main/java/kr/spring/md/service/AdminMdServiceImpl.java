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
public class AdminMdServiceImpl implements AdminMdService{

	@Autowired
	private MdMapper mdMapper;
	
	@Override
	public MdVO selectMd(int md_num) {
		return mdMapper.selectMd(md_num);
	}

	@Override
	public List<MdVO> selectList(Map<String, Object> map) {
		return mdMapper.selectList(map);
	}

	@Override
	public int selectRowCount(Map<String, Object> map) {
		return mdMapper.selectRowCount(map);
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

	@Override
	public void insertMd(MdVO md) {
		// TODO Auto-generated method stub
		
	}

}
