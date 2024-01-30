package kr.spring.reserv.vo;

import java.sql.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ReservHallVO {
	private int reservation_num;
	private int mem_num;
	private String reservation_form1;
	private String reservation_form2;
	private String reservation_form3;
	private int reservation_status;
	private Date reservation_regdate;
	private Date reservation_modifydate;
	private String reservation_name;
	private String reservation_email;
	private String reservation_phone;
	
	private MultipartFile[] upload;
	private List<Date> reservation_date;
}
