package kr.spring.member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
import kr.spring.util.AuthCheckException;
import kr.spring.util.FileUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MemberController {
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
	 * 회원가입
	 *=======================*/
	//회원가입 폼 호출
	@GetMapping("/member/register")
	public String form() {
		return "memberRegister";
	}
	
	//전송된 회원 데이터 처리
	@PostMapping("/member/register")
	public String submit(@Valid MemberVO memberVO, BindingResult result, Model model, HttpServletRequest request) {
		log.debug("<<회원가입>> : " + memberVO);
		
		//유효성 체크 결과 오류가 있으면 폼 호출
		if(result.hasErrors()) {
			for(FieldError error : result.getFieldErrors()) {
				log.debug("<<에러 필드>> : " + error.getField());
			}
			
			return form();
		}
		
		//회원가입
		memberService.insertMember(memberVO);
		
		model.addAttribute("accessTitle", "회원가입");
		model.addAttribute("accessMsg", "회원가입이 완료되었습니다.");
		model.addAttribute("accessUrl", request.getContextPath()+"/main/main");
		
		return "common/resultView";
	}
	
	/*========================
	 * 회원로그인
	 *=======================*/
	//로그인 폼 호출
	@GetMapping("/member/login")
	public String formLogin() {
		return "memberLogin";
	}
	
	//전송된 데이터 처리
	@PostMapping("/member/login")
	public String submit(@Valid MemberVO memberVO, BindingResult result, HttpSession session, HttpServletResponse response, Model model) {
		log.debug("<<회원 로그인>> : " + memberVO);
		
		//유효성 체크 결과 오류가 있으면 폼 호출
		//id와 passwd 필드만 유효성 체크
		if(result.hasFieldErrors("mem_id") || result.hasFieldErrors("mem_passwd")) {
			return formLogin();
		}
		
		//로그인 체크 (id,비밀번호 일치 여부 체크)
		MemberVO member = null;
		try {
			member = memberService.selectCheckMember(memberVO.getMem_id());
			boolean check = false;
			
			if(member != null) {
				//비밀번호 일치 여부 체크
				check = member.isCheckedPassword(memberVO.getMem_passwd());
			}
			if(check) {
				//======자동로그인 체크 시작======//
				//======자동로그인 체크 끝=======//
				//인증 성공, 로그인 처리
				session.setAttribute("user", member);
				log.debug("<<인증 성공>>");
				log.debug("<<id>>" + member.getMem_id());
				log.debug("<<mem_num>>" + member.getMem_num());
				log.debug("<<mem_auth>>" + member.getMem_auth());
				log.debug("<<mem_au_id>>" + member.getMem_au_id());
				
				if(member.getMem_auth() == 9) {//관리자는 관리자 메인으로 이동
					//======추후 수정======//
					return "redirect:/main/main";
				}else {//일반 사용자는 사용자 메인으로 이동
					return "redirect:/main/main";
				}
			}
			//인증 실패
			throw new AuthCheckException();
		}catch(AuthCheckException e) {
			log.debug("<<인증 실패>>");
			//인증 실패로 로그인 폼 호출
			if(member != null && member.getMem_auth() == 0) {//탈퇴회원 메시지 표시
				result.reject("noAuthority");
			}else {
				result.reject("invalidIdOrPassword");
			}
			return formLogin();
		}
	}
	
	/*========================
	 * 로그아웃
	 *=======================*/
	@RequestMapping("/member/logout")
	public String processLogout(HttpSession session, HttpServletResponse response) {
		//로그아웃
		session.invalidate();
		//=======자동로그인 처리=======//
		//=====자동로그인 처리 끝=======//
		return "redirect:/main/main";
	}
	
	/*========================
	 * MyPage
	 *=======================*/
	@RequestMapping("/member/myPage")
	public String process(HttpSession session, Model model) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		log.debug("<<mem_num>> : " + user.getMem_num());
		
		//회원 정보
		MemberVO member = memberService.selectMember(user.getMem_num());
		
		log.debug("<<회원 상세 정보>> : " + member);
		
		model.addAttribute("member", member);
		
		return "myPage";
	}
	/*========================
	 * 프로필 사진 출력
	 *=======================*/
	//프로필 사진 출력(로그인 전용)
	@RequestMapping("/member/photoView")
	public String getProfile(HttpSession session, HttpServletRequest request, Model model) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		log.debug("<<프로필 사진 읽기>> " + user);
		if(user == null) {//로그인이 되지 않은 경우
			getBasicProfileImage(request, model);
		}else {//로그인 된 경우
			MemberVO memberVO = memberService.selectMember(user.getMem_num());
			viewProfile(memberVO, request, model);
		}
		//빈의 이름이 imageView인 ImageView 객체 호출
		return "imageView";
	}
	//프로필 사진 출력(회원번호 지정)
	@RequestMapping("/member/viewProfile")
	public String getProfileByMem_num(@RequestParam int mem_num,HttpServletRequest request,Model model) {
		MemberVO memberVO = memberService.selectMember(mem_num);
		
		viewProfile(memberVO,request,model);
		
		return "imageView";
	}
	//프로필 사진 처리를 위한 공통 코드
	public void viewProfile(MemberVO memberVO, HttpServletRequest request, Model model) {
		if(memberVO == null || memberVO.getMem_filename() == null) {
			//업로드한 프로필 사진 정보가 없어서 기본 이미지 표시
			getBasicProfileImage(request, model);
		}else {//업로드한 이미지 읽기
			model.addAttribute("imageFile", memberVO.getMem_photo());
			model.addAttribute("filename", memberVO.getMem_filename());
		}
	}
	//기본 이미지 읽기
	public void getBasicProfileImage(HttpServletRequest request, Model model) {
		byte[] readbyte = FileUtil.getBytes(request.getServletContext().getRealPath("/image_bundle/face.png"));
		model.addAttribute("imageFile", readbyte);
		model.addAttribute("filename", "face.png");
	}
	
	/*========================
	 * 회원 정보 수정
	 *=======================*/
	//회원 정보 수정 폼 호출
	@GetMapping("/member/update")
	public String updateForm(@RequestParam int mem_num,Model model) {
		MemberVO memberVO = memberService.selectMember(mem_num);

		model.addAttribute("memberVO", memberVO);
		
		return "memberUpdate";
	}
	
	//수정폼에서 전송된 회원 데이터 처리
	@PostMapping("/member/update")
	public String submitUpdate(@Valid MemberVO memberVO, BindingResult result, HttpServletRequest request, Model model) {
		log.debug("<<회원 정보 수정>> : " + memberVO);
		
		if(result.hasErrors()) {
			MemberVO member = memberService.selectMember(memberVO.getMem_num());
			memberVO.setMem_num(member.getMem_num());
			return "memberUpdate";
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
	@GetMapping("/member/passwdUpdate")
	public String passwdUpdateForm(@RequestParam int mem_num, Model model) {
		log.debug("<<비밀번호 변경 폼 mem_num>> : " + mem_num);
		return "memberPasswdUpdate";
	}
	
	@PostMapping("/member/passwdUpdate")
	public String passwdUpdate(MemberVO member, @RequestParam String mem_passwd, @RequestParam String mem_newpasswd, @RequestParam String mem_confirmpasswd, HttpSession session, HttpServletRequest request, Model model){
		
		//입력한 현재 비밀번호 일치 체크
		MemberVO user = (MemberVO)session.getAttribute("user");
		MemberVO db_member = memberService.selectMember(user.getMem_num());

		if(!mem_passwd.equals(db_member.getMem_passwd())) {//현재 비밀번호와 입력한 비밀번호 불일치
			return "memberPasswdUpdate";
		}
		
		//변경할 비밀번호와 변경할 비밀번호 일치 체크
		if(!mem_newpasswd.equals(mem_confirmpasswd)) {//변경할 비밀번호와 변경할 비밀번호 불일치
			return "memberPasswdUpdate";
		}
		
		//비밀번호 변경
		memberService.Member_newPasswd(member);
		
		//비밀번호 변경 완료 메시지 보여준 후 로그아웃 처리
		session.invalidate();
		
		model.addAttribute("accessTitle", "회원탈퇴");
		model.addAttribute("accessMsg", "회원탈퇴가 완료되었습니다.");
		model.addAttribute("accessUrl", request.getContextPath()+"/main/main");
		
		return "common/resultView";
	}
	/*========================
	 * 회원 탈퇴
	 *=======================*/
	//회원 탈퇴 폼 호출
	@GetMapping("/member/withdraw")
	public String withdrawForm(@RequestParam int mem_num) {
		log.debug("<<탈퇴 폼 mem_num>> : " + mem_num);
		return "memberWithdraw";
	}
	//탈퇴폼에서 전송된 회원 데이터 처리
	@PostMapping("/member/withdraw")
	public String submitWithdraw(@RequestParam String mem_ckpasswd, HttpSession session, HttpServletRequest request, Model model) {
		
		MemberVO member = (MemberVO)session.getAttribute("user");
		String mem_passwd = member.getMem_passwd();
		
		log.debug("<<회원 탈퇴 기존 비밀번호>> : " + mem_passwd);
		log.debug("<<회원 탈퇴 입력한 비밀번호>> : " + mem_ckpasswd);
		
		if(!mem_passwd.equals(mem_ckpasswd)) {
			return "memberWithdraw";
		}
		
		memberService.deleteMemeber_detail(member);
		
		session.invalidate();
		
		model.addAttribute("accessTitle", "회원탈퇴");
		model.addAttribute("accessMsg", "회원탈퇴가 완료되었습니다.");
		model.addAttribute("accessUrl", request.getContextPath()+"/main/main");
		
		return "common/resultView";
	}
}
