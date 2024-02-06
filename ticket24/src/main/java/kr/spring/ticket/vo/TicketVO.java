package kr.spring.ticket.vo;

import java.sql.Date;


import javax.validation.constraints.NotBlank;

import org.hibernate.validator.constraints.Range;
import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class TicketVO {
	private int ticket_num;
	private int mem_num;
	@Range(min=1,max=4) //1:뮤지컬,2:공연,3:콘서트,4:클래식
	private int ticket_category;
	@NotBlank
	private String ticket_name;
	private String ticket_date;
	@NotBlank
	private String temp_date;
	@NotBlank
	private String temp_time;
	@Range(min=1,max=999)
	private int ticket_quantity;
	@Range(min=1,max=99999999)
	private int ticket_price;
	@NotBlank
	private String ticket_place;
	@NotBlank
	private String ticket_seat;
	private String ticket_special1;
	private String[] f_ticket_special1;
	private String ticket_special2;
	private String[] f_ticket_special2;
	private int ticket_hit;
	private Date ticket_regdate;
	private Date ticket_modifydate;
	@NotBlank
	private String ticket_content;
	private MultipartFile Upload;
	private MultipartFile Upload2;
	private MultipartFile Upload3;
	private MultipartFile Upload4;
	private String ticket_filename1;
	private String ticket_filename2;
	private String ticket_filename3;
	private String ticket_filename4;
	private int ticket_status;
	
	private String mem_id;
	private String mem_nickname;
		
	//form:checkbox에서 사용할 수 있도록 String -> String[]로 변환
	public String[] getF_ticket_special1() {
		String[] f_ticket_special1 = null;
		if(ticket_special1!=null) f_ticket_special1 = ticket_special1.split(",");
		return f_ticket_special1;
	}
	
	public String[] getF_ticket_special2() {
		String[] f_ticket_special2 = null;
		if(ticket_special2!=null) f_ticket_special2 = ticket_special2.split(",");
		return f_ticket_special2;
	}
	
	//String[] -> String
	public void setF_ticket_special1(String[] f_ticket_special1) {
		if(f_ticket_special1!=null) {
			this.ticket_special1 = "";
			for(int i=0;i<f_ticket_special1.length;i++) {
				if(i>0) this.ticket_special1 +=",";
				this.ticket_special1 += f_ticket_special1[i];
			}
		}
	}
	
	public void setF_ticket_special2(String[] f_ticket_special2) {
		if(f_ticket_special2!=null) {
			this.ticket_special2 = "";
			for(int i=0;i<f_ticket_special2.length;i++) {
				if(i>0) this.ticket_special2 +=",";
				this.ticket_special2 += f_ticket_special2[i];
			}
		}
	}
	
}


