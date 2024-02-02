package kr.spring.chat.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
								Model model, HttpSession session) {
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		//채팅방 생성
		chatRoomVO.setMem_num(user.getMem_num());
		chatService.insertChatRoom(chatRoomVO);
		
		model.addAttribute("user", user);
		model.addAttribute("chatroom_num", chatRoomVO.getChatroom_num());
		
		return "redirect:/chat/chatDetail?chatroom_num=" + chatRoomVO.getChatroom_num();
	}
	
	// 채팅방 상세 페이지
	@RequestMapping("/chat/chatDetail")
	public String chatDetailPage(@RequestParam("chatroom_num") int chatroom_num, Model model, HttpSession session) {
	    MemberVO user = (MemberVO) session.getAttribute("user");

	    model.addAttribute("user", user);
	    model.addAttribute("chatroom_num", chatroom_num);

	    return "chatDetail"; // 실제 채팅방 상세 페이지
	}
}







