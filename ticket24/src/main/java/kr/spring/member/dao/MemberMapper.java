package kr.spring.member.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.comm.vo.CommVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.question.vo.QuestionVO;
import kr.spring.ticket.vo.TicketVO;

@Mapper
public interface MemberMapper {
	//회원관리 - 사용자
	@Select("SELECT member_seq.nextval FROM dual")
	public int selectMem_num();
	
	//회원가입
	public void insertMember(MemberVO member);
	public void insertMember_detail(MemberVO member);
	@Select("SELECT member_point_seq.nextval FROM dual")
	public int selectPt_num();
	public void insertMember_point(MemberVO member);
	
	//아이디찾기
	public MemberVO selectMemberId(MemberVO member);
	//비밀번호찾기
	public MemberVO selectMemberPw(String mem_id, String mem_name, String mem_email);
	@Update("UPDATE member_detail SET mem_passwd=#{str} WHERE mem_email=#{mem_email}")
	public void updateUserPassword(String mem_email, String str);
	//자동 로그인
	@Update("UPDATE member_detail SET mem_au_id=#{mem_au_id} WHERE mem_num=#{mem_num}")
	public void updateAu_id(String mem_au_id, int mem_num);
	@Select("SELECT mem_num,mem_id,mem_auth,mem_au_id,mem_passwd,mem_nickname,mem_email FROM member JOIN member_detail USING(mem_num) WHERE mem_au_id=#{mem_au_id}")
	public MemberVO selectAu_id(String mem_au_id);
	public void deleteAu_id(int mem_num);
		
	//회원 정보
	public MemberVO selectCheckMember(String id);
	@Select("SELECT * FROM member JOIN member_detail USING(mem_num) WHERE mem_num=#{mem_num}")
	public MemberVO selectMember(int mem_num);
	//포인트 테이블
	@Select("SELECT * FROM member_point WHERE mem_num=#{mem_num}")
	public MemberVO selectMemberPoint(int mem_num);
	//포인트 합계 구하기
	@Select("SELECT NVL(SUM(pt_amount),0) AS pt_sum FROM member_point WHERE mem_num=#{mem_num}")
	public int selectMemberPointSum(int mem_num);
	
	//회원 정보 업데이트
	@Update("UPDATE member SET mem_nickname=#{mem_nickname} WHERE mem_num=#{mem_num}")
	public void updateMember(MemberVO member);
	public void updateMember_detail(MemberVO member);
	public void updateMember_point(MemberVO member);
	//비밀번호 변경
	@Update("UPDATE member_detail SET mem_passwd=#{mem_newpasswd} WHERE mem_num=#{mem_num}")
	public void Member_newPasswd(MemberVO member);
	
	//회원 포인트 조회
	public List<MemberVO> selectPointList(Map<String,Object> map);
	public int selectRowCount(Map<String,Object> map);

	//마이페이지 커뮤니티 조회(내가 작성한 글)
	@Select("SELECT * FROM comm JOIN member USING(mem_num) WHERE mem_num=#{mem_num} ORDER BY comm_regdate DESC")
	public List<CommVO> selectWriteList(int mem_num);
	//마이페이지 커뮤니티 조회(좋아요한 글)
	public List<CommVO> selectFavList(int mem_num);
	//마이페이지 내가 작성한 글 개수/검색 글 개수
	public int selectWriteRowCount(Map<String,Object> map);
	//마이페이지 내가 작성한 글
	public List<CommVO> selectAllWriteList(Map<String,Object> map);
	//마이페이지 좋아요한 글 개수/검색 글 개수
	public int selectFavRowCount(Map<String,Object> map);
	//마이페이지 좋아요한 글
	public List<CommVO> selectAllFavList(Map<String,Object> map);
	//마이페이지 티켓 양도 내역
	public List<TicketVO> selectTicketList(Map<String,Object> map);
	public int selectTicketRowCount(Map<String,Object> map);
	//마이페이지 1:1문의
	public int selectQuestionRowCount(Map<String,Object> map);
	public List<QuestionVO> selectQuestionList(Map<String,Object> map);
	
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