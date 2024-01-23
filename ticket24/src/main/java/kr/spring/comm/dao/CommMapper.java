package kr.spring.comm.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Update;

import kr.spring.comm.vo.CommVO;

@Mapper
public interface CommMapper {
	//부모글
	public List<CommVO> selectList(Map<String,Object> map);
	public int selectRowCount(Map<String,Object> map);
	public void insertComm(CommVO comm);
	public CommVO selectComm(int comm_num);
	@Update("UPDATE comm SET comm_hit=comm_hit+1 WHERE comm_num=#{comm_num}")
	public void updateComm_hit(int comm_num);
	public void updateComm(CommVO comm);
	@Delete("DELETE FROM comm WHERE comm_num=#{comm_num}")
	public void deleteComm(int comm_num);
	@Update("UPDATE comm SET comm_filename='' WHERE comm_num=#{comm_num}")
	public void deleteFile(int comm_num);
}
