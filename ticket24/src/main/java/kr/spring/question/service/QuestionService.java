package kr.spring.question.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Update;

import kr.spring.question.vo.QuestionVO;

public interface QuestionService {
	public List<QuestionVO> selectList(Map<String,Object> map);
	public int selectRowCount(Map<String,Object> map);
	public void insertQuestion(QuestionVO question);
	public void updateRenum(int question_num);
	public QuestionVO selectQuestion(int question_num);
	public QuestionVO selectAnswer(int question_num);
	public void updateHit(int question_num);
	public void updateQuestion(QuestionVO question);
	public void updateAnswer(QuestionVO question);
	public void deleteQuestion(int question_num);
	public void deleteAnswer(int question_num);
	public void deleteFile(int question_num);
	public void deletePasswd(QuestionVO question);
	public void updateStatus(int question_num);
}
