package kr.spring.mreview.vo;

import java.sql.Date;

import javax.validation.constraints.NotBlank;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MdReviewVO {
	private int md_review_num;
	@NotBlank
	private String md_title;
	@NotBlank
	private String md_content;
	private Date  md_regdate;
	private Date md_mdate;
	private MultipartFile upload;
	private String md_filename;
	private String md_ip;
	private int mem_num;
	
	private String mem_id;
	private String mem_nickname;
	
	private int fav_cnt;//좋아요 개수
}





