package kr.spring.member.service;

import java.util.List;
import java.util.Map;

import kr.spring.comm.vo.CommVO;
import kr.spring.member.vo.MemberVO;

public interface MemberService {
	//회원관리 - 사용자
	public void insertMember(MemberVO member);
	public void updateAu_id(String mem_au_id, int mem_num);
	public MemberVO selectAu_id(String mem_au_id);
	public void deleteAu_id(int mem_num);
	public MemberVO selectMemberId(MemberVO member);
	public MemberVO selectMemberPw(String mem_id, String mem_name, String mem_email);
	public void updateUserPassword(String mem_id, String mem_passwd);
	public MemberVO selectCheckMember(String id);
	public MemberVO selectMember(int mem_num);
	public void updateMember(MemberVO member);
	public void Member_newPasswd(MemberVO member);
	public void deleteMemeber_detail(MemberVO member);
	public MemberVO selectMemberPoint(int mem_num);
	public int selectMemberPointSum(int mem_num);
	public List<CommVO> selectWriteList(int mem_num);
	public List<CommVO> selectFavList(int mem_num);
	public int selectWriteRowCount(Map<String,Object> map);
	public List<CommVO> selectAllWriteList(Map<String,Object> map);
	public int selectFavRowCount(Map<String,Object> map);
	public List<CommVO> selectAllFavList(Map<String,Object> map);
	//회원 포인트 조회
	public List<MemberVO> selectPointList(Map<String,Object> map);
	public int selectRowCount(Map<String,Object> map);
	//프로필 이미지 업데이트
	public void updateProfile(MemberVO member);
}
