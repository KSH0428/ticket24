package kr.spring.member.service;

import kr.spring.member.vo.MemberVO;

public interface MemberService {
	//회원관리 - 사용자
	public void insertMember(MemberVO member);
	public MemberVO selectCheckMember(String id);
	public MemberVO selectMember(int mem_num);
	public void updateMember(MemberVO member);
	public void updateMember_detail(MemberVO member);
	public void updateMember_point(MemberVO member);
	public void deleteMember(int mem_num);
	public void deleteMemeber_detail(MemberVO member);
	public void deleteMemeber_point(MemberVO member);
	
	//회원관리 - 관리자
}
