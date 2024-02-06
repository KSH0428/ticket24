package kr.spring.mdcart.vo;

import java.sql.Date;

import kr.spring.md.vo.MdVO;
import kr.spring.mdorder.vo.MdOrderVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MdCartVO {
	private int md_cart_num;
	private int order_quantity;
	private Date cart_rdate;
	private int md_num;
	private int mem_num;
	private int sub_price;
	
	private MdOrderVO mdOrderVO;
	
	private MdVO mdVO;

}
