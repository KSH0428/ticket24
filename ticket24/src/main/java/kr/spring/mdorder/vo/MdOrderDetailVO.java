package kr.spring.mdorder.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MdOrderDetailVO {
	
	private int md_detail_num;		//주문상세번호
	private int md_num;		//상품번호
	private String md_item_name;	//상품명
	private int md_item_price;		//가격
	private int md_item_total;		//동일상품의 총주문가격
	private int order_quantity; //주문수량
	private int md_order_num;		//주문번호	
	
}
