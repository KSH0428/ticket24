package kr.spring.chat.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ChatRoomVO {
	private int chatroom_num;
	private int mem_num;
	
	private String mem_id;
	private ChatMessageVO chatMessageVO;
	private int read_count;
}
