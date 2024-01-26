package kr.spring.comm.vo;

import kr.spring.util.DurationFromNow;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CommReplyVO {
	private int comm_renum;
	private String comm_recontent;
	private String comm_redate;
	private String comm_remodifydate;
	private String comm_reip;
	private int comm_num;
	private int mem_num;
	
	private String mem_id;
	private String mem_nickname;
	
	public void setComm_redate(String comm_redate) {
		this.comm_redate = DurationFromNow.getTimeDiffLabel(comm_redate);
	}
	
	public void setComm_remodifydate(String comm_remodifydate) {
		this.comm_remodifydate = DurationFromNow.getTimeDiffLabel(comm_remodifydate);
	}
	
}
