package kr.spring.question.vo;

import java.sql.Date;

import javax.validation.constraints.NotBlank;

import org.hibernate.validator.constraints.Range;
import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class QuestionVO {
	private int question_num;
	private int mem_num;
	private String question_ip;
	@Range(min=1,max=3)
	private int question_category;
	@NotBlank
	private String question_title;
	@Range(min=1,max=3)
	private int question_lock;
	private String question_passwd;
	private MultipartFile upload;
	private String question_photo;
	@NotBlank
	private String question_content;
	private Date question_regdate;
	private Date question_modifydate;
	private int question_level;
	private int question_renum;
	private int question_hit;
	private int question_status; //0:답변미완료,1:답변완료
	
	private String mem_id;
	private String mem_nickname;
	private int mem_auth;
}
