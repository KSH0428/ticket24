package kr.spring.question.vo;

import java.sql.Date;

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
	private int question_category;
	private String question_title;
	private int question_lock;
	private String question_passwd;
	private MultipartFile upload;
	private String question_photo;
	private String question_content;
	private Date question_regdate;
	private Date question_modifydate;
	private int question_level;
	private int question_renum;
	private int question_hit;
	
	private String mem_id;
	private String mem_nickname;
	private int mem_auth;
}