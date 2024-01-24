package kr.spring.faq.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import kr.spring.faq.vo.FaqVO;

@Mapper
public interface FaqMapper {
	public void insertFaq(FaqVO faq);
	public void updateFaq(FaqVO faq);
	@Delete("DELETE FROM faq WHERE faq_num=#{faq_num}")
	public void deleteFaq(int faq_num);
	public List<FaqVO> selectFaqList(Map<String,Object> map);
	@Select("SELECT * FROM faq WHERE faq_num=#{faq_num}")
	public FaqVO selectFaq(int faq_num);
}
