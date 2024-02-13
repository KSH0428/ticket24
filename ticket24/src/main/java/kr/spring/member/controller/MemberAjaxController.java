package kr.spring.member.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Pattern;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.member.service.MemberService;
import kr.spring.member.service.SendEmailService;
import kr.spring.member.vo.MailVO;
import kr.spring.member.vo.MemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MemberAjaxController {
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private SendEmailService sendEmailService;
	
	/*==========================
	 * 아이디 중복 체크
	 *=========================*/
	@RequestMapping("/member/confirmId")
	@ResponseBody
	public Map<String,String> process(@RequestParam String mem_id){
		log.debug("<<아이디 중복 체크>> : " + mem_id);
		
		Map<String,String> mapAjax = new HashMap<String,String>();
		
		MemberVO member = memberService.selectCheckMember(mem_id);
		if(member!=null) {
			//아이디 중복
			mapAjax.put("result", "idDuplicated");
		}else {
			if(!Pattern.matches("^[A-Za-z0-9]{4,12}$",mem_id)) {
				//패턴 불일치
				mapAjax.put("result", "notMatchPattern");
			}else {
				//패턴이 일치하면서 아이디 미중복
				mapAjax.put("result", "idNotFound");
			}
		}
		return mapAjax;
	}
	
	/*==========================
	 * 회원가입 이메일 인증
	 *=========================*/
	@GetMapping("/member/mailCheck")
	@ResponseBody
	public String mailCheck(String mem_email,HttpSession session) {
	    String str = sendEmailService.getTempPassword(); // 랜덤한 인증번호 생성

	    session.setAttribute("email_val", str);
	    
	    MailVO vo = sendEmailService.createMailconfirmEmail(mem_email, str); // 인증번호를 이메일 서비스에 전달
	    sendEmailService.mailSend(vo); // 이메일 발송

	    return str; // 생성된 인증번호를 반환하여 클라이언트에게 전송
	}
	
	/*==========================
	 * 프로필 사진 업데이트
	 *=========================*/
	@RequestMapping("/member/updateMyPhoto")
	@ResponseBody
	public Map<String,String> profileUpdate(MemberVO memberVO, HttpSession session){
		Map<String,String> map = new HashMap<String,String>();
		MemberVO user = (MemberVO)session.getAttribute("user");

		if(user == null) {
			map.put("result", "logout");
		}else {
			memberVO.setMem_num(user.getMem_num());
			memberService.updateProfile(memberVO);
			
			map.put("result", "success");
		}
		
		return map;
	}
}