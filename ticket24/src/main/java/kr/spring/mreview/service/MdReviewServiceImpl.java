package kr.spring.mreview.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.mreview.dao.MdReviewMapper;
import kr.spring.mreview.vo.MdReviewFavVO;
import kr.spring.mreview.vo.MdReviewVO;

@Service
@Transactional
public class MdReviewServiceImpl implements MdReviewService{
	@Autowired
	private MdReviewMapper mdReviewMapper;

	@Override
	public int selectRowCount(Map<String, Object> map) {
		return mdReviewMapper.selectRowCount(map);
	}

	@Override
	public void insertMdReview(MdReviewVO review) {
		mdReviewMapper.insertMdReview(review);
		
	}

	@Override
	public MdReviewVO selectMdReview(int md_review_num) {
		return mdReviewMapper.selectMdReview(md_review_num);
	}

	@Override
	public void updateMdReview(MdReviewVO review) {
		mdReviewMapper.updateMdReview(review);
		
	}

	@Override
	public void deleteMdReview(int md_review_num) {
		//부모글 좋아요 삭제
		mdReviewMapper.deleteFavByReviewNum(md_review_num);
		//부모글 삭제
		mdReviewMapper.deleteMdReview(md_review_num);
	}

	@Override
	public void deleteFile(int md_review_num) {
		mdReviewMapper.deleteFile(md_review_num);
	}

	@Override
	public MdReviewFavVO selectFav(MdReviewFavVO fav) {
		return mdReviewMapper.selectFav(fav);
	}

	@Override
	public int selectFavCount(int md_review_num) {
		return mdReviewMapper.selectFavCount(md_review_num);
	}

	@Override
	public void insertFav(MdReviewFavVO fav) {
		mdReviewMapper.insertFav(fav);
	}

	@Override
	public void deleteFav(MdReviewFavVO reviewFav) {
		mdReviewMapper.deleteFav(reviewFav);
	}

	@Override
	public List<MdReviewVO> selectList(Map<String, Object> map) {
		return mdReviewMapper.selectList(map);
	}

	
}




