package kr.spring.event.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import kr.spring.event.vo.EventReplyVO;
import kr.spring.event.vo.EventVO;
import kr.spring.member.vo.MemberVO;

public interface EventService {
	public List<EventVO> selectList(Map<String,Object> map);
	public int selectRowCount(Map<String,Object>map);
	public void insertEvent(EventVO event);
	public EventVO selectEvent(int event_num);
	public void updateHit(int event_num);
	public void updateEvent(EventVO event);
	public void deleteEvent(int event_num);
	public void deleteFile(int event_num);

	//이벤트 댓글
	public List<EventReplyVO> selectListReply(Map<String,Object> map);
	public int selectRowCountReply(Map<String,Object> map);
	public EventReplyVO selectReply(int event_renum);
	public void insertReply(EventReplyVO eventReply);
	public void updateReply(EventReplyVO eventReply);
	public void deleteReply(int event_renum);
	public int countReply(@Param("event_num") int event_num, 
			   			  @Param("mem_num") int mem_num);
	//이벤트 적립
	public void insertPoint(MemberVO member);
}
