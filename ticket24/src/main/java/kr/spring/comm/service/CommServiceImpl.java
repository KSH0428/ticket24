package kr.spring.comm.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.comm.dao.CommMapper;
import kr.spring.comm.vo.CommVO;

@Service
@Transactional
public class CommServiceImpl implements CommService {
	@Autowired
	private CommMapper commMapper;
	@Override
	public List<CommVO> selectList(Map<String, Object> map) {
		return commMapper.selectList(map);	
	}

	@Override
	public int selectRowCount(Map<String, Object> map) {
		return commMapper.selectRowCount(map);
	}

	@Override
	public void insertComm(CommVO comm) {
		commMapper.insertComm(comm);
		
	}

	@Override
	public CommVO selectComm(int comm_num) {
		return commMapper.selectComm(comm_num);
	}

	@Override
	public void updateComm_hit(int comm_num) {
		commMapper.updateComm_hit(comm_num);		
	}

	@Override
	public void updateComm(CommVO comm) {
		commMapper.updateComm(comm);
		
	}

	@Override
	public void deleteComm(int comm_num) {
		//부모글삭제
		//commMapper.deleteFavByCommNum(comm_num);
		//댓글이 존재하면 댓글을 우선 삭제하고 부모글 삭제
		//commMapper.deleteReplyByCommNum(comm_num);
		//부모글삭제
		commMapper.deleteComm(comm_num);
		
	}

	@Override
	public void deleteFile(int comm_num) {
		commMapper.deleteFile(comm_num);
		
	}
	
}
