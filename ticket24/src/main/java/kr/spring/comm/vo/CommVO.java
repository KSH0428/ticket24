package kr.spring.comm.vo;

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
public class CommVO {		
	private int comm_num;
	@NotBlank
	private String comm_title;
	@NotBlank
	private String comm_content;
	@Range(min=1, max=5) //1:자유게시판,2:뮤지컬,3:연극,4:콘서트,5:클래식
	private int comm_category;
	private int comm_hit;
	private Date comm_regdate;
	private Date comm_modifydate;
	private MultipartFile Upload;
	private String comm_filename;
	private String comm_ip;
	private int mem_num;
	
	private String mem_id;
	private String mem_nickname;
	
	private int re_cnt; //댓글 개수
	private int fav_cnt; //좋아요 개수
	
}
