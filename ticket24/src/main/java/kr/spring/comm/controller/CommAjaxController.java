package kr.spring.comm.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.comm.service.CommService;
import kr.spring.comm.vo.CommVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.util.FileUtil;
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
	
}
