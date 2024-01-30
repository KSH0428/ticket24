package kr.spring.question.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.member.vo.MemberVO;
import kr.spring.question.service.QuestionService;
import kr.spring.question.vo.QuestionVO;
import kr.spring.util.FileUtil;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class QuestionAjaxController {
	@Autowired
	private QuestionService questionService;
	
	/*=======================
	 * 문의글 업로드 파일 삭제
	 *=======================*/
	@RequestMapping("/question/deleteFile")
	@ResponseBody
	public Map<String,String> processFile(int question_num, HttpSession session,
										  HttpServletRequest request){
		Map<String,String> mapJson = new HashMap<String, String>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user == null) {
			mapJson.put("result", "logout");
		}else {
			QuestionVO vo = questionService.selectQuestion(question_num);
			
			questionService.deleteFile(question_num);
			FileUtil.removeFile(request, vo.getQuestion_photo());
			
			mapJson.put("result", "success");
		}
		
		return mapJson;
	}
}
