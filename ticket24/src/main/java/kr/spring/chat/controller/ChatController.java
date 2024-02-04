package kr.spring.chat.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.chat.service.ChatService;
import kr.spring.chat.vo.ChatMessageVO;
import kr.spring.chat.vo.ChatRoomVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.util.PageUtil;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class ChatController {
	@Autowired
	private ChatService chatService;
	
	/*==========================
	 * 메인페이지
	 *==========================*/
	@RequestMapping("/chat/main")
	public String main(@RequestParam(value="pageNum",defaultValue="1") int currentPage,
						HttpSession session, Model model) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("mem_num", user.getMem_num());
		
		int count = chatService.selectRowCount(map);
		
		PageUtil page = new PageUtil(null,null,currentPage,
				                         count,30,10,"main");
		
		List<ChatRoomVO> list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			list = chatService.selectChatRoomList(map);
		}
		model.addAttribute("count", count);
		model.addAttribute("list", list);
		model.addAttribute("page", page.getPage());
		
		return "chatMain";
	}
	
	/*==========================
	 * 채팅하기
	 *==========================*/
	//채팅 메시지 페이지 호출
	@RequestMapping("/chat/chatDetail")
	public String chatDetail(ChatRoomVO chatRoomVO, ChatMessageVO chatMessageVO, 
								Model model, HttpSession session, @RequestParam(value = "chatroom_num", defaultValue = "0") int chatroom_num) {
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		//채팅방 생성
		chatRoomVO.setMem_num(user.getMem_num());
		List<ChatRoomVO> list = chatService.selectChatList(user.getMem_num());
		if(list.size()>0) {
			log.debug("chatroom_num : " + chatroom_num);
			return "/chat/chatDetail";
		}else {
			int nchatroom_num = chatService.insertChatRoom(chatRoomVO);
			return "redirect:/chat/chatDetail?chatroom_num=" + nchatroom_num;
		}
	}
	
	// 채팅방 메시지 읽기
	@RequestMapping("/chat/chatDetailAjax")
	@ResponseBody
	public Map<String,Object> chatDetailAjax(@RequestParam int chatroom_num,
												HttpSession session){
		log.debug("<<chatroom_num>>" + chatroom_num);
		Map<String,Object> mapAjax = new HashMap<String, Object>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user==null) {//로그인이 되지 않은 경우
			mapAjax.put("result", "logout");
		}else {//로그인 된 경우
			Map<String,Integer> map = new HashMap<String,Integer>();
			map.put("chatroom_num", chatroom_num);
			map.put("mem_num", user.getMem_num());
			List<ChatMessageVO> list = chatService.selectChatDetail(map);
			
			mapAjax.put("result", "success");
			mapAjax.put("list", list);
			mapAjax.put("user_num", user.getMem_num());			
		}		
		return mapAjax;
	}
	
	//채팅 메시지 전송
	@RequestMapping("/chat/writeChat")
	@ResponseBody
	public Map<String,Object> writeChatAjax(ChatMessageVO vo, HttpSession session){
		log.debug("<<vo : >> " + vo);
		Map<String,Object> mapAjax = new HashMap<String,Object>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user==null) {//로그인이 되지 않은 경우
			mapAjax.put("result", "logout");
		}else {//로그인 된 경우
			vo.setMem_num(user.getMem_num());
			
			log.debug("<<채팅 메시지 등록 ChatMessageVO>> : " + vo);
			chatService.insertChat(vo);
			
			mapAjax.put("result", "success");
		}
		return mapAjax;
	}
}







