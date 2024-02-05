package kr.spring.reserv.vo;

import java.sql.Date;

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
	private String payment_name;
	private String payment_phone;
	private int payment_status;
	private String payment_method;
	private String payment_email;
}
