package kr.spring.event.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.event.vo.EventReplyVO;
import kr.spring.event.vo.EventVO;
import kr.spring.member.vo.MemberVO;

@Mapper
public interface EventMapper {
	//이벤트 게시판
	public List<EventVO> selectList(Map<String,Object> map);
	public int selectRowCount(Map<String,Object>map);
	public void insertEvent(EventVO event);
	@Select("SELECT * FROM event WHERE event_num=#{event_num}")
	public EventVO selectEvent(int event_num);
	@Update("UPDATE event SET event_hit=event_hit+1 WHERE event_num=#{event_num}")
	public void updateHit(int event_num);
	public void updateEvent(EventVO event);
	@Delete("DELETE FROM event WHERE event_num=#{event_num}")
	public void deleteEvent(int event_num);
	@Update("UPDATE event SET event_photo1='', event_photo2='', event_photo3='' WHERE event_num=#{event_num}")
	public void deleteFile(int event_num);
	
	//이벤트 댓글
	public List<EventReplyVO> selectListReply(Map<String,Object> map);
	@Select("SELECT COUNT(*) FROM event_reply WHERE event_num=#{event_num}")
	public int selectRowCountReply(Map<String,Object> map);
	@Select("SELECT * FROM event_reply WHERE event_renum=#{event_renum}")
	public EventReplyVO selectReply(int event_renum);
	public void insertReply(EventReplyVO eventReply);
	@Update("UPDATE event_reply SET event_recontent=#{event_recontent},"
			+ "event_reip=#{event_reip},event_modifydate=SYSDATE WHERE event_renum=#{event_renum}")
	public void updateReply(EventReplyVO eventReply);
	@Delete("DELETE FROM event_reply WHERE event_renum=#{event_renum}")
	public void deleteReply(int event_renum);
	//부모글 삭제시 댓글이 존재하면 부모글 삭제 전 댓글 삭제
	//부모글 지울때 딸려있는 자식 데이터도 삭제해야됨
	@Delete("DELETE FROM event_reply WHERE event_num=#event_num")
	public void deleteReplyByEventNum(int event_num);
	//이벤트 참여 횟수 제한
	@Select("SELECT COUNT(*) FROM event_reply WHERE event_num=#{event_num} AND mem_num=#{mem_num}")
	public int countReply(@Param("event_num") int event_num, 
								   @Param("mem_num") int mem_num);
	
	//적립금 적립
	public void insertPoint(MemberVO member);
}
