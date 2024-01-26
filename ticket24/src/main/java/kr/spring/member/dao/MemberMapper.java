package kr.spring.member.dao;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.member.vo.MemberVO;

@Mapper
public interface MemberMapper {
	//회원관리 - 사용자
	@Select("SELECT member_seq.nextval FROM dual")
	public int selectMem_num();
	
	//회원가입
	public void insertMember(MemberVO member);
	public void insertMember_detail(MemberVO member);
	
	//회원가입 및 포인트 관리
	@Select("SELECT member_point_seq.nextval FROM dual")
	public int selectPt_num();
	public void insertMember_point(MemberVO member);
	
	//회원 정보
	public MemberVO selectCheckMember(String id);
	@Select("SELECT * FROM member JOIN member_detail USING(mem_num) JOIN member_point USING(mem_num) WHERE mem_num=#{mem_num}")
	public MemberVO selectMember(int mem_num);
	
	//회원 정보 업데이트
	@Update("UPDATE member SET mem_nickname=#{mem_nickname} WHERE mem_num=#{mem_num}")
	public void updateMember(MemberVO member);
	public void updateMember_detail(MemberVO member);
	public void updateMember_point(MemberVO member);
	//비밀번호 변경
	@Update("UPDATE member SET mem_passwd=#{mem_newpasswd} WHERE mem_num=#{mem_num}")
	public void Member_newPasswd(MemberVO member);
	
	//회원 탈퇴
	@Update("UPDATE member SET mem_auth=0 WHERE mem_num=#{mem_num}")
	public void updateMember_withdraw_auth(MemberVO member);
	@Delete("DELETE FROM member_detail WHERE mem_num=#{mem_num}")
	public void deleteMemeber_detail(MemberVO member);
	@Delete("DELETE FROM member_point WHERE mem_num=#{mem_num}")
	public void deleteMemeber_point(MemberVO member);	
	
	//프로필 이미지 업데이트
	@Update("UPDATE member_detail SET mem_filename=#{mem_filename}, mem_photo=#{mem_photo} WHERE mem_num=#{mem_num}")
	public void updateProfile(MemberVO member);
	//회원관리 - 관리자
}