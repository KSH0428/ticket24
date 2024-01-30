package kr.spring.mreview.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.mreview.vo.MdReviewFavVO;
import kr.spring.mreview.vo.MdReviewVO;

@Mapper
public interface MdReviewMapper {
	//부모글
	public List<MdReviewVO> selectList(Map<String,Object> map);
	public int selectRowCount(Map<String,Object> map);
	public void insertMdReview(MdReviewVO review);
	public MdReviewVO selectMdReview(int md_review_num);
	public void updateMdReview(MdReviewVO review);
	@Delete("DELETE FROM md_review WHERE md_review_num=#{md_review_num}")
	public void deleteMdReview(int md_review_num);
	@Update("UPDATE md_review SET md_filename='' WHERE md_review_num=#{md_review_num}")
	public void deleteFile(int md_review_num);

	//좋아요
	@Select("SELECT * FROM md_review_fav WHERE md_review_num=#{md_review_num} AND mem_num=#{mem_num}")
	public MdReviewFavVO selectFav(MdReviewFavVO fav);
	@Select("SELECT COUNT(*) from md_review_fav WHERE md_review_num=#{md_review_num}")
	public int selectFavCount(int md_review_num);
	@Insert("INSERT INTO md_review_fav (md_review_num,mem_num) VALUES (#{md_review_num},#{mem_num})")
	public void insertFav(MdReviewFavVO fav);
	@Delete("DELETE FROM md_review_fav WHERE md_review_num=#{md_review_num} AND mem_num=#{mem_num}")
	public void deleteFav(MdReviewFavVO reviewFav);
	@Delete("DELETE FROM md_review_fav WHERE md_review_num=#{md_review_num}")
	public void deleteFavByReviewNum(int md_review_num);

}










