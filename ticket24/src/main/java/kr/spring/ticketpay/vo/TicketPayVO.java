package kr.spring.ticketpay.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class TicketPayVO {
	private int ticket_pay_num;
	private int ticket_num;
	private int ticket_pay_price;
	private String ticket_pay_name;
	private String ticket_pay_zipcode;
	private String ticket_pay_address1;
	private String ticket_pay_address2;
	private String ticket_pay_phone;
	private int ticket_pay_method;
	private int mem_num;
	
}
