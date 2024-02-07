package kr.spring.question.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Update;

import kr.spring.question.vo.QuestionVO;

@Mapper
public interface QuestionMapper {
	//회원 일대일 문의
	public List<QuestionVO> selectList(Map<String,Object> map);
	public int selectRowCount(Map<String,Object> map);
	public void insertQuestion(QuestionVO question);
	@Update("UPDATE question SET question_renum=question_num WHERE question_num=#{question_num}")
	public void updateRenum(int question_num); //관리자 답변시 원글번호 저장
	public QuestionVO selectQuestion(int question_num);
	public QuestionVO selectAnswer(int question_num);
	@Update("UPDATE question SET question_hit=question_hit+1 WHERE question_num=#{question_num}")
	public void updateHit(int question_num);
	public void updateQuestion(QuestionVO question);
	@Update("UPDATE question SET question_content=#{question_content},question_modifydate=SYSDATE WHERE question_num=#{question_num}")
	public void updateAnswer(QuestionVO question);
	@Delete("DELETE FROM question WHERE question_num=#{question_num}")
	public void deleteQuestion(int question_num);
	@Delete("DELETE FROM question WHERE question_renum=#{question_num}")
	public void deleteAnswer(int question_num);
	@Update("UPDATE question SET question_photo='' WHERE question_num=#{question_num}")
	public void deleteFile(int question_num);
	//비밀글 공개로 했을 때 비밀번호 삭제
	@Update("UPDATE question SET question_passwd='' WHERE question_num=#{question_num}")
	public void deletePasswd(QuestionVO question);
	//답변 작성시 상태 업데이트
	@Update("UPDATE question SET question_status=1 WHERE question_num=#{question_num}")
	public void updateStatus(int question_num);
	//답변 삭제시 상태 업데이트
	@Update("UPDATE question SET question_status=0 WHERE question_num=#{question_num}")
	public void deleteStatus(int question_num);
}
