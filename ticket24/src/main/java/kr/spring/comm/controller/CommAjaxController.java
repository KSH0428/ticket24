package kr.spring.comm.controller;

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

import kr.spring.comm.service.CommService;
import kr.spring.comm.vo.CommFavVO;
import kr.spring.comm.vo.CommReplyVO;
import kr.spring.comm.vo.CommVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.util.FileUtil;
import kr.spring.util.PageUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class CommAjaxController {
	@Autowired
	private CommService commService;
	/*==============================
	 * 부모글 업로드 파일 삭제
	 *=============================*/
	@RequestMapping("/comm/deleteFile")
	@ResponseBody
	public Map<String,String> processFile(int comm_num, HttpSession session, HttpServletRequest request){
		
		Map<String,String> mapJson = new HashMap<String,String>();
		
		MemberVO user= (MemberVO)session.getAttribute("user");
		if(user==null) {
			mapJson.put("result", "logout");			
		}else {
			CommVO vo = commService.selectComm(comm_num);
			
			commService.deleteFile(comm_num);
			FileUtil.removeFile(request, vo.getComm_filename());
			
			mapJson.put("result", "success");
		}
		return mapJson;
	}
	/*==============================
	 * 부모글 좋아요 읽기
	 *=============================*/
	@RequestMapping("/comm/getFav")
	@ResponseBody
	public Map<String,Object> getFav(CommFavVO fav, HttpSession session){
		
		log.debug("<<게시판 좋아요 CommFavVO>> : " +fav);
		
		Map<String,Object> mapJson = new HashMap<String,Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user==null) {
			mapJson.put("status", "noFav");
		}else {
			//로그인된 회원번호 셋팅
			fav.setMem_num(user.getMem_num());
			
			CommFavVO commFav = commService.selectFav(fav);
			if(commFav!=null) {
				mapJson.put("status", "yesFav");
			}else {
				mapJson.put("status", "noFav");
			}
		}
		//좋아요 수
		mapJson.put("count", commService.selectFavCount(fav.getComm_num()));
		
		return mapJson;
	}
	/*==============================
	 * 부모글 좋아요 등록/삭제
	 *=============================*/
	 @RequestMapping("comm/writeFav")
	 @ResponseBody
	 public Map<String,Object> writeFav(CommFavVO fav, HttpSession session){
		 log.debug("<<부모글 좋아요 등록/삭제 CommFavVO>> : " + fav);
		 
		 Map<String, Object> mapJson = new HashMap<String,Object>();
		 
		 MemberVO user = (MemberVO)session.getAttribute("user");
		 if(user==null) {
			 mapJson.put("result", "logout");
		 }else {
			 //로그인된 회원번호 셋팅
			 fav.setMem_num(user.getMem_num());
			 
			 //이전에 좋아요를 등록했는지 여부 확인
			 CommFavVO commFavVO = commService.selectFav(fav);
			 if(commFavVO!=null) {//좋아요를 이미 등록
				 commService.deleteFav(fav);//좋아요 삭제
				 mapJson.put("status", "noFav");			 
			 }else {//좋아요 미등록
				 commService.insertFav(fav);//좋아요 등록
				 mapJson.put("status", "yesFav");
			 }
			 mapJson.put("result", "success");
			 mapJson.put("count", commService.selectFavCount(fav.getComm_num()));
		 }
		 
		 return mapJson;
	 }
	 /*==============================
	  * 댓글 등록
	  *=============================*/
	 @RequestMapping("/comm/writeReply")
	 @ResponseBody
	 public Map<String,String> writeReply(CommReplyVO commReplyVO,
			 							  HttpSession session,
			 							  HttpServletRequest request){
		 log.debug("<<댓글 등록 CommReplyVO>> : " + commReplyVO);
		 
		 Map<String,String> mapJson = new HashMap<String, String>();
		 
		 MemberVO user = (MemberVO)session.getAttribute("user");
		 if(user==null) {
			 //로그인 안됨
			 mapJson.put("result", "logout");			 
		 }else {
			 //회원번호 등록
			 commReplyVO.setMem_num(user.getMem_num());
			 //ip등록
			 commReplyVO.setComm_reip(request.getRemoteAddr());
			 //댓글 등록
			 commService.insertReply(commReplyVO);
			 mapJson.put("result", "success");
		 }
		 return mapJson;
	 }
	 /*==============================
	  * 댓글 목록
	  *=============================*/
	 @RequestMapping("/comm/listReply")
	 @ResponseBody
	 public Map<String,Object> getList(
			 @RequestParam(value="pageNum",defaultValue="1") int currentPage,
			 @RequestParam(value="rowCount",defaultValue="10") int rowCount,
			 @RequestParam int comm_num,HttpSession session){
		 	 log.debug("<<댓글 목록 comm_num>> : " + comm_num);
		 	 
		 	 Map<String,Object> map = new HashMap<String,Object>();
		 	 map.put("comm_num", comm_num);
		 	 
		 	 //전체 레코드 수
		 	 int count = commService.selectRowCountReply(map);
		 	 //페이지 처리
		 	 PageUtil page = new PageUtil(currentPage,count,rowCount);
		 	 
		 	 List<CommReplyVO> list = null;
		 	 if(count > 0) {
		 		 map.put("start", page.getStartRow());
		 		 map.put("end", page.getEndRow());
		 		 list = commService.selectListReply(map);
		 	 }else {
		 		 list = Collections.emptyList();
		 	 }
		 	 
		 	 Map<String,Object> mapJson = new HashMap<String,Object>();
		 	 mapJson.put("count", count);
		 	 mapJson.put("list", list);
		 	 
		 	 //로그인 한 회원정보 셋팅
		 	 MemberVO user = (MemberVO)session.getAttribute("user");
		 	 if(user!=null) {
		 		 mapJson.put("user_num", user.getMem_num());
		 	 }
		 	 
		 	 return mapJson;
	 }
	 /*==============================
	  * 댓글 수정
	  *=============================*/
	 @RequestMapping("/comm/updateReply")
	 @ResponseBody
	 public Map<String,String> modifyReply(CommReplyVO commReplyVO, HttpSession session, HttpServletRequest request){
		 log.debug("<<댓글 수정 CommReplyVO>> : " + commReplyVO);
		 
		 Map<String,String> mapJson = new HashMap<String,String>();
		 
		 MemberVO user = (MemberVO)session.getAttribute("user");
		 CommReplyVO db_reply = commService.selectReply(commReplyVO.getComm_renum());
		 if(user==null) {
			 //로그인이 되지 않은 경우
			 mapJson.put("result", "logout");
		 }else if(user!=null && user.getMem_num()==db_reply.getMem_num()) {
			 //로그인한 회원번호와 작성자 회원번호 일치
			 
			 //ip등록
			 commReplyVO.setComm_reip(request.getRemoteAddr());
			 //댓글 수정
			 commService.updateReply(commReplyVO);
			 mapJson.put("result", "success");
		 }else {
			 //로그인한 회원번호와 작성자 회원번호 불일치
			 mapJson.put("result", "wrongAccess");
		 }
		 
		 return mapJson;
	 }
	 /*==============================
	  * 댓글 삭제
	  *=============================*/
	 @RequestMapping("/comm/deleteReply")
	 @ResponseBody
	 public Map<String,String> deleteReply(@RequestParam int comm_renum, HttpSession session){

		 log.debug("<<댓글 삭제 comm_renum>> : " + comm_renum);

		 Map<String,String> mapJson = new HashMap<String,String>();

		 MemberVO user = (MemberVO)session.getAttribute("user");
		 CommReplyVO db_reply = commService.selectReply(comm_renum);
		 if(user==null) {
			 //로그인이 되지 않은 경우
			 mapJson.put("result", "logout");
		 }else if(user!=null && user.getMem_num()==db_reply.getMem_num()) {
			 //로그인한 회원번호와 작성자 회원번호가 일치
			 commService.deleteReply(comm_renum);
			 mapJson.put("result", "success");
		 }else {
			 //로그인한 회원번호와 작성자 회원번호가 불일치
			 mapJson.put("result", "wrongAccess");
		 }

		 return mapJson;
	 }
}
