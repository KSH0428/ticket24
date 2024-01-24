package kr.spring.faq.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.faq.dao.FaqMapper;
import kr.spring.faq.vo.FaqVO;

@Service
@Transactional
public class FaqServiceImpl implements FaqService{
	@Autowired
	private FaqMapper faqMapper;
	
	@Override
	public void insertFaq(FaqVO faq) {
		faqMapper.insertFaq(faq);
	}

	@Override
	public void updateFaq(FaqVO faq) {
		faqMapper.updateFaq(faq);
	}

	@Override
	public void deleteFaq(int faq_num) {
		faqMapper.deleteFaq(faq_num);
	}

	@Override
	public List<FaqVO> selectFaqList(Map<String, Object> map) {
		return faqMapper.selectFaqList(map);
	}

	@Override
	public FaqVO selectFaq(int faq_num) {
		return faqMapper.selectFaq(faq_num);
	}
}
