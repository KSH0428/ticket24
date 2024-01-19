package kr.spring.member.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import kr.spring.member.vo.MemberVO;

@Mapper
public interface MemberMapper {
	//회원관리 - 사용자
	@Select("SELECT member_seq.nextval FROM dual")
	public int selectMem_num();
	public void insertMember(MemberVO member);
	public void insertMember_detail(MemberVO member);
	@Select("SELECT member_point_seq.nextval FROM dual")
	public int selectPt_num();
	public void insertMember_point(MemberVO member);
	public MemberVO selectCheckMember(String id);
	@Select("SELECT * FROM member JOIN member_detail USING(mem_num) WHERE mem_num=#{mem_num}")
	public MemberVO selectMember(int mem_num);
	public void updateMember(MemberVO member);
	public void updateMember_detail(MemberVO member);
	public void updateMember_point(MemberVO member);
	public void deleteMember(int mem_num);
	public void deleteMemeber_detail(MemberVO member);
	public void deleteMemeber_point(MemberVO member);	
	
	//회원관리 - 관리자
}
