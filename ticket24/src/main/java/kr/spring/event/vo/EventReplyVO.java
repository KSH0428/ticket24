package kr.spring.event.vo;

import kr.spring.util.DurationFromNow;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class EventReplyVO {
	private int event_renum;
	private String event_recontent;
	private String event_regdate;
	private String event_modifydate;
	private String event_reip;
	private int event_num;
	private int mem_num;
	
	private String mem_id;
	private String mem_nickname;
	
	public void setRe_date(String event_regdate) {
		this.event_regdate = DurationFromNow.getTimeDiffLabel(event_regdate);
	}
	
	public void setRe_mdate(String event_modifydate) {
		this.event_modifydate = DurationFromNow.getTimeDiffLabel(event_modifydate);
	}
}
