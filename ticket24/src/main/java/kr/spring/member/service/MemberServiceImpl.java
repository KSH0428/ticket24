package kr.spring.member.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.member.dao.MemberMapper;
import kr.spring.member.vo.MemberVO;

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
	public void updateMember_point(MemberVO member) {
		// TODO Auto-generated method stub
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

}
