package kr.spring.comm.service;

import java.util.List;
import java.util.Map;

import kr.spring.comm.vo.CommVO;

public interface CommService {
	//부모글
	public List<CommVO> selectList(Map<String,Object> map);
	public int selectRowCount(Map<String,Object> map);
	public void insertComm(CommVO comm);
	public CommVO selectComm(int comm_num);
	public void updateComm_hit(int comm_num);
	public void updateComm(CommVO comm);
	public void deleteComm(int comm_num);
	public void deleteFile(int comm_num);
}
