package kr.spring.admin.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class adminController {
	@Autowired
	private MemberService memberService;
	/*==========================
	 * 자바빈(VO) 초기화
	 *=========================*/
	@ModelAttribute
	public MemberVO initCommand() {
		return new MemberVO();
	}
	
	/*========================
	 * AdminPage
	 *=======================*/
	@RequestMapping("/admin/adminPage")
	public String process(HttpSession session, Model model) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		log.debug("<<mem_num>> : " + user.getMem_num());
		
		//회원 정보
		MemberVO member = memberService.selectMember(user.getMem_num());
		int all_point = memberService.selectMemberPointSum(user.getMem_num());
		
		log.debug("<<회원 상세 정보>> : " + member);
		log.debug("<<회원 포인트 합계>> : " + all_point);
		
		model.addAttribute("member", member);
		model.addAttribute("all_point", all_point);
		
		return "adminPage";
	}
	
	/*========================
	 * 회원 정보 수정
	 *=======================*/
	//회원 정보 수정 폼 호출
	@GetMapping("/admin/update")
	public String updateForm(@RequestParam int mem_num,Model model) {
		MemberVO memberVO = memberService.selectMember(mem_num);

		model.addAttribute("memberVO", memberVO);
		
		return "adminUpdate";
	}
	
	//수정폼에서 전송된 회원 데이터 처리
	@PostMapping("/admin/update")
	public String submitUpdate(@Valid MemberVO memberVO, BindingResult result, HttpServletRequest request, Model model) {
		log.debug("<<회원 정보 수정>> : " + memberVO);
		
		if(result.hasErrors()) {
			MemberVO member = memberService.selectMember(memberVO.getMem_num());
			memberVO.setMem_num(member.getMem_num());
			return "adminUpdate";
		}

		memberService.updateMember(memberVO);
		
		model.addAttribute("message", "회원 정보 수정 완료");
		model.addAttribute("url", request.getContextPath()+"/member/update?mem_num="+memberVO.getMem_num());
		
		return "common/resultAlert";
	}
	/*========================
	 * 회원 비밀번호 변경
	 *=======================*/
	//회원 정보 수정 폼 호출
	@GetMapping("/admin/passwdUpdate")
	public String passwdUpdateForm(@RequestParam int mem_num, Model model) {
		log.debug("<<회원 비밀번호 수정>> : " + mem_num);
		model.addAttribute("mem_num", mem_num);
		return "adminPasswdUpdate";
	}
	@PostMapping("/admin/passwdUpdate")
	public String passwdUpdate(@Valid MemberVO memberVO, BindingResult result, HttpSession session, HttpServletRequest request, Model model){
		if(result.hasFieldErrors("mem_passwd")||result.hasFieldErrors("mem_newpasswd")||result.hasFieldErrors("mem_confirmpasswd")) {
			List<FieldError> list = result.getFieldErrors(); 
			for(FieldError error : list) {
				log.debug("<<에러 필드>> : " + error.getField());
			}
			return "adminPasswdUpdate";
		}
		//입력한 현재 비밀번호 일치 체크 
		MemberVO user = (MemberVO)session.getAttribute("user");
		MemberVO db_member = memberService.selectMember(user.getMem_num());
		
		log.debug("<<비밀번호 변경 mem_num>> : " + memberVO.getMem_num());
		log.debug("<<비밀번호 변경 newpasswd>> : " + memberVO.getMem_newpasswd());
		
		if(!memberVO.getMem_passwd().equals(db_member.getMem_passwd())) {//현재 비밀번호와 입력한 비밀번호 불일치
			result.rejectValue("mem_passwd", "invalidPassword");
			return "adminPasswdUpdate";
		}
		
		//변경할 비밀번호와 확인 비밀번호 일치 체크
		if(!memberVO.getMem_newpasswd().equals(memberVO.getMem_confirmpasswd())) {//변경할 비밀번호와 확인 비밀번호 불일치
			result.rejectValue("mem_newpasswd", "invalidConfirm");
			return "adminPasswdUpdate";
		}
		
		//비밀번호 변경
		memberService.Member_newPasswd(memberVO);
		
		model.addAttribute("message", "비밀번호 변경이 완료되었습니다.");
		model.addAttribute("url", request.getContextPath()+"/admin/adminPage");
		
		return "common/resultAlert";
	}
	
}