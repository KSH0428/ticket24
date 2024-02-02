package kr.spring.chat.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.spring.chat.service.ChatService;
import kr.spring.chat.vo.ChatMessageVO;
import kr.spring.chat.vo.ChatRoomVO;
import kr.spring.member.vo.MemberVO;
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
	public String main() {
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
	
	// 채팅방 상세 페이지
	
}







