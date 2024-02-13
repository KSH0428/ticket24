package kr.spring.member.controller;

import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.Cookie;
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
import org.springframework.web.servlet.ModelAndView;

import kr.spring.comm.service.CommService;
import kr.spring.comm.vo.CommVO;
import kr.spring.member.service.MemberService;
import kr.spring.member.service.SendEmailService;
import kr.spring.reserv.service.ReservService;
import kr.spring.member.vo.MailVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.question.vo.QuestionVO;
import kr.spring.reserv.vo.ReservHallVO;
import kr.spring.ticket.vo.TicketVO;
import kr.spring.ticketpay.service.TicketPayService;
import kr.spring.ticketpay.vo.TicketPayVO;
import kr.spring.util.AuthCheckException;
import kr.spring.util.FileUtil;
import kr.spring.util.PageUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MemberController {
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private SendEmailService sendEmailService;
	
	@Autowired
	private ReservService reservService;
	
	@Autowired
	private TicketPayService ticketPayService;
	
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
		model.addAttribute("accessUrl", request.getContextPath()+"/concert/list");
		
		return "common/resultView";
	}
	/*========================
	 * 아이디 찾기
	 *=======================*/
	@GetMapping("/member/findIdCheck")
	public String findIdForm() {
		return "findIdCheck";
	}
	
	@PostMapping("/member/findIdCheck")
	public String findIdCheck(@RequestParam String mem_name,
							  @RequestParam String mem_email,
							  @Valid MemberVO member,BindingResult result,
							  Model model,HttpServletRequest request) {
		
		if(result.hasFieldErrors("mem_name") || result.hasFieldErrors("mem_email")) {
			return findIdForm();
		}

		member.setMem_name(mem_name);
		member.setMem_email(mem_email);
		
		//아이디 찾기
		MemberVO mem_id = memberService.selectMemberId(member);
		
		if(mem_id == null) {
			result.reject("noMember");
			return findIdForm();
		}
		
		model.addAttribute("mem_id", mem_id);
		model.addAttribute("url", request.getContextPath()+"/member/login");
		
		return "findIdResult";
	}
	
	/*========================
	 * 비밀번호 찾기
	 *=======================*/	
	@GetMapping("/member/findPwCheck")
	public String findPwForm() {
		return "findPwCheck";
	}

	@PostMapping("/member/findPwCheck")
	public String findPwCheck(@RequestParam String mem_id,
							  @RequestParam String mem_name,
							  @RequestParam String mem_email,
							  @Valid MemberVO member, BindingResult result, HttpSession session,
							  Model model, HttpServletRequest request) {
		if(result.hasFieldErrors("mem_id") || result.hasFieldErrors("mem_name") || result.hasFieldErrors("mem_email")) {
			return findPwForm();
		}
		
		member = memberService.selectMemberPw(mem_id, mem_name, mem_email);
		
		log.debug("<<비밀번호찾기 >> : " + member);
		log.debug("<<비밀번호찾기 >> : " + mem_name);
		log.debug("<<비밀번호찾기 >> : " + mem_id);
		log.debug("<<비밀번호찾기 >> : " + mem_email);
		
		if(member == null) {
			result.reject("noMember");
			return findPwForm();
		}else if(!member.getMem_name().equals(mem_name)) {
			result.reject("invalidName");
			return findPwForm();
        }else if(!member.getMem_id().equals(mem_id)) {
        	result.reject("invalidId");
        	return findPwForm();
        }else if(!member.getMem_email().equals(mem_email)) {
        	result.reject("invalidEmail");
        	return findPwForm();
        }

		MailVO vo = sendEmailService.createMailAndChangePassword(mem_email, mem_name, mem_id);
        sendEmailService.mailSend(vo);
        
		return "findPwResult";		
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
			if(check) {//인증성공
				//======자동로그인 체크 시작======//
				boolean autoLogin = memberVO.getMem_auto() != null && memberVO.getMem_auto().equals("on");
				if(autoLogin) {
					//자동로그인 체크를 한 경우
					String mem_au_id = member.getMem_au_id();
					if(mem_au_id==null) {
						mem_au_id = UUID.randomUUID().toString();
						log.debug("<<mem_au_id>> : " + mem_au_id);
						member.setMem_au_id(mem_au_id);
						memberService.updateAu_id(member.getMem_au_id(),member.getMem_num());
					}
					Cookie auto_cookie = new Cookie("au-log",mem_au_id);
					auto_cookie.setMaxAge(60*60^24*7);//유효기간 1주일
					auto_cookie.setPath("/");
					
					response.addCookie(auto_cookie);
				}
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
					return "redirect:/concert/list";
				}else {//일반 사용자는 사용자 메인으로 이동
					return "redirect:/concert/list";
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
		//클라이언트쿠키 처리
		Cookie auto_cookie = new Cookie("au-log","");
		auto_cookie.setMaxAge(0);
		auto_cookie.setPath("/");
		
		response.addCookie(auto_cookie);
		//=====자동로그인 처리 끝=======//
		return "redirect:/concert/list";
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
		int all_point = memberService.selectMemberPointSum(user.getMem_num());
		
		log.debug("<<회원 상세 정보>> : " + member);
		log.debug("<<회원 포인트 합계>> : " + all_point);
		
		model.addAttribute("member", member);
		model.addAttribute("all_point", all_point);
		
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
	 * 포인트 리스트 
	 *=======================*/
	@RequestMapping("/member/point")
	public ModelAndView process(@RequestParam(value="pageNum",defaultValue="1") int currentPage,HttpSession session) {
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		MemberVO member = memberService.selectMember(user.getMem_num());
		int all_point = memberService.selectMemberPointSum(user.getMem_num());
	    
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("mem_num", user.getMem_num());

		//전체/검색 레코드 수
		int count = memberService.selectRowCount(map);
		log.debug("<<count>> : " + count);
		
		PageUtil page = new PageUtil(currentPage,count,10,10,"point");

		List<MemberVO> list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = memberService.selectPointList(map);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("memberPoint");
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		mav.addObject("member", member);
		mav.addObject("all_point", all_point);
		
		return mav;
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
		log.debug("<<회원 비밀번호 수정>> : " + mem_num);
		model.addAttribute("mem_num", mem_num);
		return "memberPasswdUpdate";
	}
	@PostMapping("/member/passwdUpdate")
	public String passwdUpdate(@Valid MemberVO memberVO, BindingResult result, HttpSession session, HttpServletRequest request, Model model){
		
		if(result.hasFieldErrors("mem_passwd")||result.hasFieldErrors("mem_newpasswd")||result.hasFieldErrors("mem_confirmpasswd")) {
			List<FieldError> list = result.getFieldErrors(); 
			for(FieldError error : list) {
				log.debug("<<에러 필드>> : " + error.getField());
			}
			return "memberPasswdUpdate";
		}
		
		//입력한 현재 비밀번호 일치 체크 
		MemberVO user = (MemberVO)session.getAttribute("user");
		MemberVO db_member = memberService.selectMember(user.getMem_num());
		
		log.debug("<<비밀번호 변경 mem_num>> : " + memberVO.getMem_num());
		log.debug("<<비밀번호 변경 newpasswd>> : " + memberVO.getMem_newpasswd());
		
		if(!memberVO.getMem_passwd().equals(db_member.getMem_passwd())) {//현재 비밀번호와 입력한 비밀번호 불일치
			result.rejectValue("mem_passwd", "invalidPassword");
			return "memberPasswdUpdate";
		}
		
		//변경할 비밀번호와 확인 비밀번호 일치 체크
		if(!memberVO.getMem_newpasswd().equals(memberVO.getMem_confirmpasswd())) {//변경할 비밀번호와 확인 비밀번호 불일치
			result.rejectValue("mem_newpasswd", "invalidConfirm");
			return "memberPasswdUpdate";
		}
		
		//비밀번호 변경
		memberService.Member_newPasswd(memberVO);
		
		model.addAttribute("message", "비밀번호 변경이 완료되었습니다.");
		model.addAttribute("url", request.getContextPath()+"/member/myPage");
		
		return "common/resultAlert";
	}
	/*========================
	 * 마이페이지 찜한 공연
	 *=======================*/
	
	/*========================
	 * 마이페이지 공연 예약 내역
	 *=======================*/
	
	/*========================
	 * 마이페이지 공연장 대관
	 *=======================*/
	@RequestMapping("member/memberReserv")
	public String userReservList(HttpSession session, Model model) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		List<ReservHallVO> list = new ArrayList<ReservHallVO>();
		list = reservService.selectReservList(user.getMem_num());
		
		for(ReservHallVO reserv : list) {
			List<Date> date = new ArrayList<>();
			date = reservService.selectReservDateList(reserv.getReservation_num());
			reserv.setReservation_date(date);
		}
		
		model.addAttribute("list", list);
		
		return "memberReserv";
	}
	/*========================
	 * 마이페이지 커뮤니티
	 *=======================*/
	@RequestMapping("member/memberComm")
	public String memberWrite(HttpSession session, Model model) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		List<CommVO> list_write = new ArrayList<CommVO>();
		List<CommVO> list_fav = new ArrayList<CommVO>();
		list_write = memberService.selectWriteList(user.getMem_num());
		list_fav = memberService.selectFavList(user.getMem_num());
		
		model.addAttribute("list_write", list_write);
		model.addAttribute("list_fav", list_fav);
		
		log.debug("<<있나? lisw : " + list_write);
		log.debug("<<있나? lisf : " + list_fav);
		
		return "memberComm";
	}
	/*========================
	 * 마이페이지 작성한 게시글
	 *=======================*/
	@RequestMapping("/member/memberList")
	public ModelAndView writeprocess(@RequestParam(value="pageNum",defaultValue="1")int currentPage,
			                   @RequestParam(value="order",defaultValue="1") int order,
			                   @RequestParam(value="comm_category",defaultValue="") String comm_category,
			                   String keyfield, String keyword, HttpSession session) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		map.put("comm_category", comm_category);
		map.put("mem_num", user.getMem_num());
		
		//전체/검색 레코드 수
		int count = memberService.selectWriteRowCount(map);
		log.debug("<<count>> : " + count);
		
		PageUtil page = new PageUtil(keyfield,keyword,currentPage,count,20,10,"list","&order="+order+"&comm_category="+comm_category);
		
		List<CommVO> list = null;
		if(count > 0) {
			map.put("order", order);
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = memberService.selectAllWriteList(map);	
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("memberList");
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		
		return mav;
	}
	/*========================
	 * 마이페이지 좋아요 게시글
	 *=======================*/
	@RequestMapping("/member/memberFav")
	public ModelAndView favprocess(@RequestParam(value="pageNum",defaultValue="1")int currentPage,
			                   @RequestParam(value="order",defaultValue="1") int order,
			                   @RequestParam(value="comm_category",defaultValue="") String comm_category,
			                   String keyfield, String keyword, HttpSession session) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		map.put("comm_category", comm_category);
		map.put("mem_num", user.getMem_num());
		
		//전체/검색 레코드 수
		int count = memberService.selectFavRowCount(map);
		log.debug("<<count>> : " + count);
		
		PageUtil page = new PageUtil(keyfield,keyword,currentPage,count,20,10,"list","&order="+order+"&comm_category="+comm_category);
		
		List<CommVO> list = null;
		if(count > 0) {
			map.put("order", order);
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = memberService.selectAllFavList(map);	
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("memberFav");
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		
		return mav;
	}
	/*========================
	 * 마이페이지 양도티켓 결제 내역
	 *=======================*/
	@RequestMapping("member/memberTicket")
	public ModelAndView ticketprocess (@RequestParam(value="pageNum",defaultValue="1")int currentPage,
			@RequestParam(value="order",defaultValue="1") int order,String keyfield, String keyword,HttpSession session) {
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		map.put("mem_num", user.getMem_num());
		
		//전체/검색 레코드 수
		int count = ticketPayService.selectRowCount(map);
		log.debug("<<count>> : " + count);
		
		PageUtil page = new PageUtil(keyfield,keyword,currentPage,count,20,10,"list");
		
		List<TicketPayVO> list = null;

		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = ticketPayService.selectReservList(map);
			log.debug("<<list>> : " + list);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("memberTicket");
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		
		return mav;
	}
	/*========================
	 * 마이페이지 1:1 문의
	 *=======================*/
	@RequestMapping("/member/memberQuestion")
	public ModelAndView process(
						@RequestParam(value="pageNum",defaultValue="1") int currentPage,
						@RequestParam(defaultValue="0") int question_category, 
						String keyfield, String keyword, HttpSession session) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		map.put("question_category", question_category);
		map.put("mem_num", user.getMem_num());
		
		//전체/검색 레코드수
		int count = memberService.selectQuestionRowCount(map);
		log.debug("<<count>> : " + count);
		log.debug("<<count>> : " + count);
		
		PageUtil page = new PageUtil(keyfield, keyword, currentPage, count, 20, 10, "list");
		
		List<QuestionVO> list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = memberService.selectQuestionList(map);
		}
	
		ModelAndView mav = new ModelAndView();
		mav.setViewName("memberQuestion");
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		
		return mav;
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
