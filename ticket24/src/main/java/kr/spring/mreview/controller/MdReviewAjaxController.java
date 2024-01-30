package kr.spring.mreview.controller;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.member.vo.MemberVO;
import kr.spring.mreview.service.MdReviewService;
import kr.spring.mreview.vo.MdReviewFavVO;
import kr.spring.mreview.vo.MdReviewVO;
import kr.spring.util.FileUtil;
import kr.spring.util.PageUtil;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class MdReviewAjaxController {
	@Autowired
	private MdReviewService mdReviewService;
	
	/*=======================
	 * 부모글 업로드 파일 삭제
	 *=======================*/
	@RequestMapping("/mdReview/deleteFile")
	@ResponseBody
	public Map<String,String> processFile(int md_review_num,
			                     HttpSession session,
			                     HttpServletRequest request){
		Map<String,String> mapJson = new HashMap<String,String>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user==null) {
			mapJson.put("result", "logout");
		}else {
			MdReviewVO vo = mdReviewService.selectMdReview(md_review_num);
			
			mdReviewService.deleteFile(md_review_num);
			FileUtil.removeFile(request, vo.getMd_filename());
			
			mapJson.put("result", "success");
		}
		
		return mapJson;
	}
	
	/*=======================
	 * 부모글 좋아요 읽기
	 *=======================*/
	@RequestMapping("/mdReview/getFav")
	@ResponseBody
	public Map<String,Object> getFav(MdReviewFavVO fav, HttpSession session){
		log.debug("<<게시판 좋아요 MdReviewFavVO>> : " + fav);
		
		Map<String,Object> mapJson = new HashMap<String,Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user==null) {
			mapJson.put("status", "noFav");
		}else {
			//로그인된 회원번호 셋팅
			fav.setMem_num(user.getMem_num());
			
			MdReviewFavVO mdReviewFav = mdReviewService.selectFav(fav);
			if(mdReviewFav!=null) {
				mapJson.put("status", "yesFav");
			}else {
				mapJson.put("status", "noFav");
			}
		}
		//좋아요수
		mapJson.put("count", mdReviewService.selectFavCount(
				                          fav.getMd_review_num()));
		return mapJson;
	}
	/*=======================
	 * 부모글 좋아요 등록/삭제
	 *=======================*/
	@RequestMapping("/mdReview/writeFav")
	@ResponseBody
	public Map<String,Object> writeFav(MdReviewFavVO fav, HttpSession session){
		log.debug("<<부모글 좋아요 등록/삭제 MdReviewFavVO>> : " + fav);
		
		Map<String,Object> mapJson = new HashMap<String,Object>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user==null) {
			mapJson.put("result", "logout");
		}else {
			//로그인된 회원번호 셋팅
			fav.setMem_num(user.getMem_num());
			
			//이전에 좋아요를 등록했는지 여부 확인
			MdReviewFavVO mdReviewFavVO = mdReviewService.selectFav(fav);
			if(mdReviewFavVO!=null) {//좋아요를 이미 등록
				mdReviewService.deleteFav(fav);//좋아요 삭제
				mapJson.put("status", "noFav");
			}else {//좋아요 미등록
				mdReviewService.insertFav(fav);//좋아요 등록
				mapJson.put("status", "yesFav");
			}
			mapJson.put("result", "success");
			mapJson.put("count", mdReviewService.selectFavCount(
					                          fav.getMd_review_num()));
		}
		return mapJson;
	}
	
	
}








