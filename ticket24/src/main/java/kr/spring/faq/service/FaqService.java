package kr.spring.faq.service;

import java.util.List;
import java.util.Map;

import kr.spring.faq.vo.FaqVO;

public interface FaqService {
	public void insertFaq(FaqVO faq);
	public void updateFaq(FaqVO faq);
	public void deleteFaq(int faq_num);
	public List<FaqVO> selectFaqList(Map<String,Object> map);
	public FaqVO selectFaq(int faq_num);
}
