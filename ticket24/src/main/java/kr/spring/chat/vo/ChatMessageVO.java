package kr.spring.chat.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ChatMessageVO {
	private int chat_num;
	private int chatroom_num;
	private int mem_num;
	private String message;
	private String send_date;
	private int read_check;
	
	private String mem_id;
	private int read_count;
}
