package kr.spring.mdorder.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MdOrderVO {
	private int md_order_num;
	private String md_item_name;
	private int md_order_total;
	private int md_payment;
	private	int md_order_status;
	private String md_receive_name;
	private String md_receive_post;
	private String md_receive_address1;
	private String md_receive_address2;
	private String md_receive_phone;
	private String md_refund_bank;
	private int md_refund_bnumber;
	private String md_notice;
	private Date md_order_regdate;
	private Date md_order_mdate;
	private int mem_num;
	
}
