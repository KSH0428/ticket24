package kr.spring.member.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MailVO {
	private String to;
	private String subject;
	private String message;
}
