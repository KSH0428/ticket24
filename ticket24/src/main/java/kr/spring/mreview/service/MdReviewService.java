package kr.spring.mreview.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.mreview.vo.MdReviewFavVO;
import kr.spring.mreview.vo.MdReviewVO;

public interface MdReviewService {
	//부모글
	public List<MdReviewVO> selectList(Map<String,Object> map);
	public int selectRowCount(Map<String,Object> map);
	public void insertMdReview(MdReviewVO review);
	public MdReviewVO selectMdReview(int md_review_num);
	public void updateMdReview(MdReviewVO review);
	public void deleteMdReview(int md_review_num);
	public void deleteFile(int md_review_num);

	//좋아요
	public MdReviewFavVO selectFav(MdReviewFavVO fav);
	public int selectFavCount(int md_review_num);
	public void insertFav(MdReviewFavVO fav);
	public void deleteFav(MdReviewFavVO reviewFav);
}



