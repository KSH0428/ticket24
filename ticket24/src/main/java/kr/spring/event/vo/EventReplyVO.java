package kr.spring.event.vo;

import java.sql.Date;

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
	
	//적립금 적립
	private int event_point;
	private int pt_num;
	private int pt_amount;
	private String pt_content;
	private Date pt_reg_date;
	
	public void setRe_date(String event_regdate) {
		this.event_regdate = DurationFromNow.getTimeDiffLabel(event_regdate);
	}
	
	public void setRe_mdate(String event_modifydate) {
		this.event_modifydate = DurationFromNow.getTimeDiffLabel(event_modifydate);
	}
}
