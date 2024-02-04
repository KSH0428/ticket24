package kr.spring.chat.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.chat.dao.ChatMapper;
import kr.spring.chat.vo.ChatMessageVO;
import kr.spring.chat.vo.ChatRoomVO;

@Service
@Transactional
public class ChatServiceImpl implements ChatService{
	@Autowired
	private ChatMapper chatMapper;
	
	@Override
	public List<ChatRoomVO> selectChatRoomList(Map<String, Object> map) {
		return chatMapper.selectChatRoomList(map);
	}

	@Override
	public int selectRowCount(Map<String, Object> map) {
		return chatMapper.selectRowCount(map);
	}
	
	@Override
	public int insertChatRoom(ChatRoomVO chatRoomVO) {
		//기본키 생성
		chatRoomVO.setChatroom_num(chatMapper.selectChatRoomNum());
		chatMapper.insertChatRoom(chatRoomVO);
		return chatRoomVO.getChatroom_num();
	}

	@Override
	public List<ChatRoomVO> selectChatMember(int chatroom_num) {
		return null;
	}

	@Override
	public void insertChat(ChatMessageVO chatMessageVO) {
		chatMessageVO.setChat_num(chatMapper.selectChatNum());
		chatMapper.insertChat(chatMessageVO);
	}

	@Override
	public List<ChatMessageVO> selectChatDetail(Map<String, Integer> map) {
		return chatMapper.selectChatDetail(map);
	}

	@Override
	public void updateChatRead(int chat_num) {
		chatMapper.updateChatRead(chat_num);
	}

	@Override
	public List<ChatRoomVO> selectChatList(int mem_num) {
		return chatMapper.selectChatList(mem_num);
	}

}
