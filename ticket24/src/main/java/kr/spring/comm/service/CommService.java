package kr.spring.comm.service;

import java.util.List;
import java.util.Map;

import kr.spring.comm.vo.CommFavVO;
import kr.spring.comm.vo.CommReplyVO;
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
	//좋아요
	public CommFavVO selectFav(CommFavVO fav);
	public int selectFavCount(int comm_num);
	public void insertFav(CommFavVO fav);
	public void deleteFav(CommFavVO comm);
	//댓글
	public List<CommReplyVO> selectListReply(Map<String,Object> map);
	public int selectRowCountReply(Map<String,Object> map);
	public CommReplyVO selectReply(int comm_renum);
	public void insertReply(CommReplyVO commReply);
	public void updateReply(CommReplyVO commReply);
	public void deleteReply(int comm_renum);
}
