package kr.spring.event.service;

import java.util.List;
import java.util.Map;

import kr.spring.event.vo.EventVO;

public interface EventService {
	public List<EventVO> selectList(Map<String,Object> map);
	public int selectRowCount(Map<String,Object>map);
	public void insertEvent(EventVO event);
	public EventVO selectEvent(int event_num);
	public void updateHit(int event_num);
	public void updateEvent(EventVO event);
	public void deleteEvent(int event_num);
	public void deleteFile(int event_num);
}
