package kr.spring.faq.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class FaqVO {
	private int faq_num;
	private String faq_title;
	private String faq_content;
	private int faq_category; //1:티켓예매,2:취소/환불,3:기타
}