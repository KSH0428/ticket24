package kr.spring.md.service;

import kr.spring.md.vo.MdVO;

public interface AdminMdService{

	//상품등록
	public void insertMd(MdVO md);
	public MdVO selectMd(int md_num);

}
