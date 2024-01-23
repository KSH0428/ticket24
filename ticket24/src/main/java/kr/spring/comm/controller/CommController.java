package kr.spring.comm.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

import kr.spring.comm.service.CommService;
import kr.spring.comm.vo.CommVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class CommController {
	@Autowired
	private CommService commService;
	
	/*=======================================
	 * 게시판 글 등록
	 *======================================*/
	//자바빈(VO)초기화
	@ModelAttribute
	public CommVO initCommand() {
		return new CommVO();
	}
	//등록 폼 호출
	@GetMapping("/board/write")
	public String form() {
		
		return "commWrite";
	}
	
}
