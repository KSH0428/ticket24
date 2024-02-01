package kr.spring.chat.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.spring.chat.service.ChatService;
import kr.spring.member.service.MemberService;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class ChatController {
	@Autowired
	private ChatService chatService;
	@Autowired
	private MemberService memberService;
	
	/*==========================
	 * 메인페이지
	 *==========================*/
	@RequestMapping("/chat/main")
	public String main() {
		return "chatMain";
	}
	
	
	
}







