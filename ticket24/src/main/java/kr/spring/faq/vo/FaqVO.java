package kr.spring.faq.vo;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Range;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class FaqVO {
	private int faq_num;
	@NotBlank
	private String faq_title;
	@NotBlank
	private String faq_content;
	@Range(min=1,max=3)
	private int faq_category; //1:티켓예매,2:취소/환불,3:기타
}