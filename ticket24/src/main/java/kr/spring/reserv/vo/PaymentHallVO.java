package kr.spring.reserv.vo;

import java.sql.Date;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PaymentHallVO {
	private int reservation_num;
	private int  reservation_price;
	private Date payment_date;
	@NotBlank
	private String payment_name;
	@NotBlank
	private String payment_phone;
	private int payment_status;
	private String payment_method;
	@NotBlank
	@Email
	private String payment_email;
	
	private String imp_uid;
	private String merchant_uid;
	private String paid_at;
}
