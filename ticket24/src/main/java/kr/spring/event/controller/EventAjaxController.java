package kr.spring.event.controller;

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

import kr.spring.event.service.EventService;
import kr.spring.event.vo.EventReplyVO;
import kr.spring.event.vo.EventVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.util.FileUtil;
import kr.spring.util.PageUtil;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class EventAjaxController {
	@Autowired
	private EventService eventService;
	
	/*======================
	 * 이벤트 업로드 파일 삭제
	 =======================*/
	@RequestMapping("/event/deleteFile")
	@ResponseBody
	public Map<String,String> processFile(int event_num, HttpSession session,
										  HttpServletRequest request){
		Map<String,String> mapJson = new HashMap<String, String>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user == null) {
			mapJson.put("result", "logout");
		}else if(user != null && user.getMem_auth() == 9) {
			EventVO vo = eventService.selectEvent(event_num);
			
			eventService.deleteFile(event_num);
			
			FileUtil.removeFile(request, vo.getEvent_photo1());
			FileUtil.removeFile(request, vo.getEvent_photo2());
			
			mapJson.put("result", "success");
		}
		return mapJson;
	}
	
	/*======================
	 * 댓글 등록
	 =======================*/
	@RequestMapping("/event/writeReply")
	@ResponseBody
	public Map<String,String> writeReply(EventReplyVO eventReplyVO, HttpSession session,
											HttpServletRequest request){
		log.debug("<<댓글 등록>> : " + eventReplyVO);
		
		Map<String,String> mapJson = new HashMap<String, String>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user == null) {
			mapJson.put("result", "logout");
		}else {
			eventReplyVO.setMem_num(user.getMem_num());
			eventReplyVO.setEvent_reip(request.getRemoteAddr());
			//댓글 등록
			eventService.insertReply(eventReplyVO);
			
			//이벤트 적립금액 불러오기
			EventVO event = eventService.selectEvent(eventReplyVO.getEvent_num());
			//적립금 적립
			user.setEvent_num(eventReplyVO.getEvent_num());
			eventService.insertPoint(user);
			
			mapJson.put("result", "success");
		}
		
		return mapJson;
	}
	
	/*======================
	 * 댓글 목록
	 =======================*/
	@RequestMapping("/event/listReply")
	@ResponseBody
	public Map<String,Object> getList(@RequestParam(value="pageNum",defaultValue="1") int currentPage,
									  @RequestParam(value="rowCount",defaultValue="10") int rowCount,
									  @RequestParam int event_num, HttpSession session){
		log.debug("<<댓글 목록 event_num>> : " + event_num);
		
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("event_num", event_num);
		
		//전체 레코드수
		int count = eventService.selectRowCount(map);
		//페이지 처리
		PageUtil page = new PageUtil(currentPage, count, rowCount);
		
		List<EventReplyVO> list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = eventService.selectListReply(map);
		}
		
		Map<String,Object> mapJson = new HashMap<String, Object>();
		mapJson.put("count", count);
		mapJson.put("list", list);
		
		//로그인한 회원정보 셋팅
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user != null) {
			mapJson.put("user_num", user.getMem_num());
		}
		
		return mapJson;
	}
	
	/*======================
	 * 댓글 수정
	 =======================*/
	@RequestMapping("/event/updateReply")
	@ResponseBody
	public Map<String,String> modifyReply(EventReplyVO eventReplyVO,
										  HttpSession session, HttpServletRequest request){
		log.debug("<<댓글 수정 EventReplyVO>> : " + eventReplyVO);
		
		Map<String,String> mapJson = new HashMap<String, String>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		EventReplyVO db_reply = eventService.selectReply(eventReplyVO.getEvent_num());
		
		if(user == null) {
			mapJson.put("result", "logout");
		}else if(user != null && user.getMem_num() == db_reply.getMem_num()) {
			//ip 등록
			eventReplyVO.setEvent_reip(request.getRemoteAddr());
			//댓글 수정
			eventService.updateReply(eventReplyVO);
			
			mapJson.put("result", "success");
		}else {
			//로그인한 회원번호와 작성자 회원번호 불일치
			mapJson.put("result", "wrongAccess");
		}
		
		return mapJson;
	}
	
	/*======================
	 * 댓글 삭제
	 =======================*/
	@RequestMapping("/event/deleteReply")
	@ResponseBody
	public Map<String,String> deleteReply(@RequestParam int event_renum, HttpSession session){
		log.debug("<<댓글 삭제 event_renum>> : " + event_renum);
		
		Map<String,String> mapJson = new HashMap<String, String>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		EventReplyVO db_reply = eventService.selectReply(event_renum);
		
		if(user == null) {
			mapJson.put("result", "logout");
		}else if(user != null && user.getMem_num() == db_reply.getMem_num()) {
			eventService.deleteReply(event_renum);
			mapJson.put("result", "success");
		}else {
			mapJson.put("result", "wrongAccess");
		}
		
		return mapJson;
	}
	
}





























