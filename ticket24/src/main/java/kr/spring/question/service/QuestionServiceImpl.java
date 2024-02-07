package kr.spring.question.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.question.dao.QuestionMapper;
import kr.spring.question.vo.QuestionVO;

@Service
@Transactional
public class QuestionServiceImpl implements QuestionService{
	//의존성 주입
	@Autowired
	private QuestionMapper questionMapper;
	
	@Override
	public List<QuestionVO> selectList(Map<String, Object> map) {
		return questionMapper.selectList(map);
	}

	@Override
	public int selectRowCount(Map<String, Object> map) {
		return questionMapper.selectRowCount(map);
	}

	@Override
	public void insertQuestion(QuestionVO question) {
		questionMapper.insertQuestion(question);
	}
	
	@Override
	public void updateRenum(int question_num) {
		questionMapper.updateRenum(question_num);
	}
	
	@Override
	public QuestionVO selectQuestion(int question_num) {
		return questionMapper.selectQuestion(question_num);
	}

	@Override
	public QuestionVO selectAnswer(int question_num) {
		return questionMapper.selectAnswer(question_num);
	}
	
	@Override
	public void updateHit(int question_num) {
		questionMapper.updateHit(question_num);
	}

	@Override
	public void updateQuestion(QuestionVO question) {
		questionMapper.updateQuestion(question);
	}

	@Override
	public void updateAnswer(QuestionVO question) {
		questionMapper.updateAnswer(question);
	}

	@Override
	public void deleteQuestion(int question_num) {
		questionMapper.deleteQuestion(question_num);
	}
	

	@Override
	public void deleteAnswer(int question_num) {
		questionMapper.deleteAnswer(question_num);
		questionMapper.deleteStatus(question_num);
	}

	@Override
	public void deleteFile(int question_num) {
		questionMapper.deleteFile(question_num);
	}

	@Override
	public void deletePasswd(QuestionVO question) {
		questionMapper.deletePasswd(question);
	}

	@Override
	public void updateStatus(int question_num) {
		questionMapper.updateStatus(question_num);
	}

}
