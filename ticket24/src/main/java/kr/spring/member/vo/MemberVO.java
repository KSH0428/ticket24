package kr.spring.member.vo;

import java.io.IOException;
import java.sql.Date;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Pattern;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MemberVO {
	private int mem_num;
	@Pattern(regexp="^[A-Za-z0-9]{6,12}$")
	private String mem_id;
	private String mem_nickname;
	private int mem_auth; //0:탈퇴회원,1:실버,2:골드,3:플래티넘,9:관리자
	private String mem_au_id; //자동로그인
	@NotBlank
	private String mem_name;
	@Pattern(regexp="^[A-Za-z0-9]{6,12}$")
	private String mem_passwd;
	@NotBlank
	private String mem_phone;
	@Email
	@NotBlank
	private String mem_email;
	private String mem_zipcode;
	@NotBlank
	private String mem_address1;
	@NotEmpty
	private String mem_address2;
	private byte[] mem_photo;
	private String mem_filename; //파일명
	private Date reg_date;
	private Date modify_date;
	private String now_passwd; //비밀번호 변경
	
	private int pt_num;
	private String pt_amount;
	private String pt_content;
	private Date pt_reg_date;
	
	//테이블 생성 후 DB에 추가
	private int reserve_num; //예약 번호
	private int event_num; //이벤트 번호
	
	/*--------------------
	 * 비밀번호 일치 여부 체크 
	 *-------------------*/
	
	public boolean isCheckedPassword(String userPasswd) {
		if(mem_auth > 0 && mem_passwd.equals(userPasswd)) {
			return true;
		}
		return false;
	}
	/*--------------------
	 * 이미지 BLOB 처리 
	 *-------------------*/
	//(주의)폼에서 파일업로드 파라미터네임은 반드시 upload로 지정해야 함
	public void setUpload(MultipartFile upload) throws IOException {
		//MultipartFile -> byte[]
		setMem_photo(upload.getBytes());
		//파일명 지정
		setMem_filename(upload.getOriginalFilename());
	}
}




