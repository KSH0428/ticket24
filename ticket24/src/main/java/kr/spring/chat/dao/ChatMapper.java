package kr.spring.chat.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.chat.vo.ChatMessageVO;
import kr.spring.chat.vo.ChatRoomVO;

@Mapper
public interface ChatMapper {
	//채팅방 목록(관리자만 볼 수 있게)
	public List<ChatRoomVO> selectChatRoomList(Map<String,Object> map);
	public int selectRowCount(Map<String,Object> map);
	//채팅방 번호 생성
	@Select("SELECT chatroom_seq.nextval FROM dual")
	public int selectChatRoomNum();
	//채팅방 생성 & 멤버 등록
	@Insert("INSERT INTO chatroom (chatroom_num,mem_num) VALUES (#{chatroom_num},#{mem_num})")
	public int insertChatRoom(ChatRoomVO chatRoomVO);
	//채팅 멤버 읽기 (필요한가?)
	public List<ChatRoomVO> selectChatMember(int chatroom_num);
	//채팅 메시지 번호 생성
	@Select("SELECT chatmessage_seq.nextval FROM dual")
	public int selectChatNum();
	//채팅 메시지 등록
	@Insert("INSERT INTO chatmessage (chat_num,chatroom_num,mem_num,message) "
			+ "VALUES (#{chat_num},#{chatroom_num},#{mem_num},#{message})")
	public void insertChat(ChatMessageVO chatMessageVO);
	//채팅 메시지 읽기
	public List<ChatMessageVO> selectChatDetail(Map<String,Integer> map);
	//읽은 채팅 기록 업데이트
	@Update("UPDATE chatmessage SET read_check=0 WHERE chatroom_num=#{chatroom_num} AND mem_num!=#{mem_num}")
	public void updateChatRead(Map<String,Integer> map);
	@Select("SELECT * FROM chatroom WHERE mem_num=#{mem_num}")
	public List<ChatRoomVO> selectChatList(int mem_num);
	
	//채팅기록 삭제
	@Delete("DELETE FROM chatmessage WHERE chatroom_num=#{chatroom_num}")
	public void deleteChatMessage(int chatroom_num);
	//채팅방 삭제
	@Delete("DELETE FROM chatroom WHERE chatroom_num=#{chatroom_num}")
	public void deleteChatRoom(int chatroom_num);
}
