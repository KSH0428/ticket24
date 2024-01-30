package kr.spring.event.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.event.vo.EventVO;

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
}
