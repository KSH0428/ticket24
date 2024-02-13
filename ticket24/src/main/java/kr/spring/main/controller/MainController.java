package kr.spring.main.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.spring.member.vo.MemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MainController {
	@RequestMapping("/")
	public String init(HttpSession session) {
		return "redirect:/concert/list";
	}
	
}





