package kr.spring.ticketpay.vo;

import javax.validation.constraints.NotBlank;

import kr.spring.ticket.vo.TicketVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class TicketPayVO {
	private int ticket_pay_num;
	private int ticket_num;
	@NotBlank
	private String ticket_pay_name;
	@NotBlank
	private String ticket_pay_zipcode;
	@NotBlank
	private String ticket_pay_address1;
	@NotBlank
	private String ticket_pay_address2;
	@NotBlank
	private String ticket_pay_phone;
	private int mem_num;
	
	private TicketVO ticketVO;
	
}
