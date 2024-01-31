package kr.spring.event.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.event.dao.EventMapper;
import kr.spring.event.vo.EventReplyVO;
import kr.spring.event.vo.EventVO;

@Service
@Transactional
public class EventServiceImpl implements EventService{
	@Autowired
	private EventMapper eventMapper;
	
	@Override
	public List<EventVO> selectList(Map<String, Object> map) {
		return eventMapper.selectList(map);
	}

	@Override
	public int selectRowCount(Map<String, Object> map) {
		return eventMapper.selectRowCount(map);
	}

	@Override
	public void insertEvent(EventVO event) {
		eventMapper.insertEvent(event);
	}

	@Override
	public EventVO selectEvent(int event_num) {
		return eventMapper.selectEvent(event_num);
	}

	@Override
	public void updateHit(int event_num) {
		eventMapper.updateHit(event_num);
	}

	@Override
	public void updateEvent(EventVO event) {
		eventMapper.updateEvent(event);
	}

	@Override
	public void deleteEvent(int event_num) {
		eventMapper.deleteEvent(event_num);
		eventMapper.deleteReplyByEventNum(event_num);
	}

	@Override
	public void deleteFile(int event_num) {
		eventMapper.deleteFile(event_num);
	}

	@Override
	public List<EventReplyVO> selectListReply(Map<String, Object> map) {
		return eventMapper.selectListReply(map);
	}

	@Override
	public int selectRowCountReply(Map<String, Object> map) {
		return eventMapper.selectRowCountReply(map);
	}

	@Override
	public EventReplyVO selectReply(int event_renum) {
		return eventMapper.selectReply(event_renum);
	}

	@Override
	public void insertReply(EventReplyVO eventReply) {
		eventMapper.insertReply(eventReply);
	}

	@Override
	public void updateReply(EventReplyVO eventReply) {
		eventMapper.updateReply(eventReply);
	}

	@Override
	public void deleteReply(int event_renum) {
		eventMapper.deleteReply(event_renum);
	}
	
}
