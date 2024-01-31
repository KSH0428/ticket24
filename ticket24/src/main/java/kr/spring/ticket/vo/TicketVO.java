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
	@Range(min=1,max=4) //1:뮤지컬,2:공연,3:콘서트,4:클래식
	private int ticket_category;
	@NotBlank
	private String ticket_name;
	@NotBlank
	private String ticket_date;
	@NotBlank
	private int ticket_quantity;
	@NotBlank
	private int ticket_price;
	@NotBlank
	private String ticket_place;
	@NotBlank
	private String ticket_seat;
	private String ticket_special1;
	private String ticket_special2;
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
		
}


