package kr.spring.md.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MdVO {
	private int md_num;
	private String md_name;
	private int md_price;
	private int md_quantity;
	private String md_photo1;
	private String md_photo2;
	private String md_detail;
	private Date md_regdate;
	private Date md_mdate;
	private int md_status; //1:표시 2:미표시
}
