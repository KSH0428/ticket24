package kr.spring.member.service;

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
	public void deleteMember(int mem_num) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteMemeber_detail(MemberVO member) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteMemeber_point(MemberVO member) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateProfile(MemberVO member) {
		memberMapper.updateProfile(member);
	}

	@Override
	public void updateMember_detail(MemberVO member) {
		// TODO Auto-generated method stub
		
	}

}
