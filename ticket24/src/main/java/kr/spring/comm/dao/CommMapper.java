package kr.spring.comm.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.comm.vo.CommFavVO;
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
	//좋아요
	@Select("SELECT * FROM comm_fav WHERE comm_num={comm_num} AND mem_num={mem_num}")
	public CommFavVO selectFav(CommFavVO fav);
	@Select("SELECT COUNT(*) from comm_fav WHERE comm_num={comm_num}")
	public int selectFavCount(int comm_num);
	@Insert("INSERT INTO comm_fav (comm_num,mem_num) VALUES (#{comm_num},#{mem_num})")
	public void insertFav(CommFavVO fav);
	@Delete("DELETE FROM comm_fav WHERE comm_num=#{comm_num} AND mem_num=#{mem_num}")
	public void deleteFav(CommFavVO commFav);
	@Delete("DELETE FROM comm_fav WHERE comm_num=#{comm_num}")
	public void deleteFavByCommNum(int comm_num);
	//댓글
}
