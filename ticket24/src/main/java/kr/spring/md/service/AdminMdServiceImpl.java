package kr.spring.md.service;

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
	public void insertMd(MdVO md) {
		md.setMd_num(mdMapper.selectMd_num());
		mdMapper.insertMd(md);
	}

	@Override
	public MdVO selectMd(int md_num) {
		return mdMapper.selectMd(md_num);
	}

}
