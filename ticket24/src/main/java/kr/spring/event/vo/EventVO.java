package kr.spring.event.vo;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class EventVO {
	private int event_num;
	private String event_title;
	private Date event_start;
	private Date event_end;
	private String event_content;
	private int event_point;
	private int event_hit;
	private MultipartFile upload1;
	private MultipartFile upload2;
	private String event_photo1;
	private String event_photo2;
	private Date event_regdate;
	private Date event_modifydate; 
}
