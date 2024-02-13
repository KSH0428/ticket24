package kr.spring.member.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.comm.vo.CommVO;
import kr.spring.member.dao.MemberMapper;
import kr.spring.member.vo.MemberVO;
import kr.spring.question.vo.QuestionVO;
import kr.spring.ticket.vo.TicketVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional
public class MemberServiceImpl implements MemberService{
	@Autowired
	private MemberMapper memberMapper;

	@Override
	public void insertMember(MemberVO member) {
		member.setMem_num(memberMapper.selectMem_num());	
		memberMapper.insertMember(member);
		memberMapper.insertMember_detail(member);
		member.setPt_num(memberMapper.selectPt_num());
		memberMapper.insertMember_point(member);
	}

	@Override
	public void updateAu_id(String mem_au_id, int mem_num) {
		memberMapper.updateAu_id(mem_au_id, mem_num);		
	}

	@Override
	public MemberVO selectAu_id(String mem_au_id) {
		return memberMapper.selectAu_id(mem_au_id);
	}

	@Override
	public void deleteAu_id(int mem_num) {
		// TODO Auto-generated method stub
	}
	
	@Override
	public MemberVO selectMemberId(MemberVO member) {
		return memberMapper.selectMemberId(member);
	}

	@Override
	public MemberVO selectMemberPw(String mem_id, String mem_name, String mem_email) {
		return memberMapper.selectMemberPw(mem_id, mem_name, mem_email);
	}

	@Override
	public void updateUserPassword(String mem_id, String mem_passwd) {
		log.debug("updateUserPassword 진입");
		memberMapper.updateUserPassword(mem_id, mem_passwd);
	}

	@Override
	public MemberVO selectCheckMember(String mem_id) {
		return memberMapper.selectCheckMember(mem_id);
	}

	@Override
	public MemberVO selectMember(int mem_num) {
		return memberMapper.selectMember(mem_num);
	}

	@Override
	public void updateMember(MemberVO member) {
		memberMapper.updateMember(member);
		memberMapper.updateMember_detail(member);
	}
	
	@Override
	public void updateProfile(MemberVO member) {
		memberMapper.updateProfile(member);
	}

	@Override
	public void deleteMemeber_detail(MemberVO member) {
		memberMapper.updateMember_withdraw_auth(member);
		memberMapper.deleteMemeber_detail(member);
		memberMapper.deleteMemeber_point(member);
	}

	@Override
	public void Member_newPasswd(MemberVO member) {
		memberMapper.Member_newPasswd(member);

	}

	@Override
	public List<MemberVO> selectPointList(Map<String, Object> map) {
		return memberMapper.selectPointList(map);
	}

	@Override
	public int selectRowCount(Map<String, Object> map) {
		return memberMapper.selectRowCount(map);
	}

	@Override
	public MemberVO selectMemberPoint(int mem_num) {
		return memberMapper.selectMemberPoint(mem_num);
	}

	@Override
	public int selectMemberPointSum(int mem_num) {
		return memberMapper.selectMemberPointSum(mem_num);
	}

	@Override
	public List<CommVO> selectWriteList(int mem_num) {
		return memberMapper.selectWriteList(mem_num);
	}

	@Override
	public List<CommVO> selectFavList(int mem_num) {
		return memberMapper.selectFavList(mem_num);
	}

	@Override
	public int selectWriteRowCount(Map<String, Object> map) {
		return memberMapper.selectWriteRowCount(map);
	}

	@Override
	public List<CommVO> selectAllWriteList(Map<String,Object> map) {
		return memberMapper.selectAllWriteList(map);
	}

	@Override
	public int selectFavRowCount(Map<String,Object> map) {
		return memberMapper.selectFavRowCount(map);
	}
	
	@Override
	public List<TicketVO> selectTicketList(Map<String, Object> map) {
		return memberMapper.selectTicketList(map);
	}

	@Override
	public int selectTicketRowCount(Map<String, Object> map) {
		return memberMapper.selectTicketRowCount(map);
	}

	@Override
	public List<CommVO> selectAllFavList(Map<String,Object> map) {
		return memberMapper.selectAllFavList(map);
	}

	@Override
	public int selectQuestionRowCount(Map<String, Object> map) {
		return memberMapper.selectQuestionRowCount(map);
	}

	@Override
	public List<QuestionVO> selectQuestionList(Map<String, Object> map) {
		return memberMapper.selectQuestionList(map);
	}

	
}
