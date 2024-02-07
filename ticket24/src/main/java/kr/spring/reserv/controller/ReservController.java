package kr.spring.reserv.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.member.vo.MemberVO;
import kr.spring.reserv.service.ReservService;
import kr.spring.reserv.vo.PaymentHallVO;
import kr.spring.reserv.vo.ReservHallVO;
import kr.spring.util.FileUtil;
import kr.spring.util.PageUtil;
import lombok.extern.slf4j.Slf4j;
    
@Controller
@Slf4j
public class ReservController {
	@Autowired
	private ReservService reservService;
	
	
	@ModelAttribute
	public ReservHallVO initCommand() {
		return new ReservHallVO();
	}
	
	
	@GetMapping("/reserv/list")
	public String reservList(Model model) {
		List<String> date = reservService.selectReservDate();
		model.addAttribute("date", date);
		
		return "reservList";
	}
	
	@PostMapping("/reserv/list")
	public String reservDate(@RequestParam List<Date> reservation_date,Model model){
		
		
		log.debug("<<reservForm으로 가는 reservation_date>> : "+ reservation_date);
	    model.addAttribute("reservation_date", reservation_date);
	    return "reservForm";
	}
	
	@PostMapping("/reserv/reservation")
	public String reservation(@Valid ReservHallVO reservHallVO, BindingResult result, 
			HttpServletRequest request, HttpSession session, Model model) throws IllegalStateException, IOException{
		log.debug("<<대관 예약 reservVO>> : " + reservHallVO);
		log.debug("<<대관 예약 reservdate>> : " + reservHallVO.getReservation_date());
		
		if(result.hasErrors()) {
			model.addAttribute("reservation_date", reservHallVO.getReservation_date());
			return "reservForm";
		}
		
		MemberVO member = (MemberVO)session.getAttribute("user");
		reservHallVO.setMem_num(member.getMem_num());
		
		for(int i=0;i<reservHallVO.getUpload().length;i++) {
			 switch (i) {
             case 0:
                 reservHallVO.setReservation_form1(FileUtil.createFile(request, reservHallVO.getUpload()[i]));
                 break;
             case 1:
            	 reservHallVO.setReservation_form2(FileUtil.createFile(request, reservHallVO.getUpload()[i]));
                 break;
             case 2:
            	 reservHallVO.setReservation_form3(FileUtil.createFile(request, reservHallVO.getUpload()[i]));
                 break;
			 }
		}
		log.debug("<<대관 예약 파일변환후 reservVO>> : " + reservHallVO);
		reservService.insertReserv(reservHallVO);
	    
		model.addAttribute("message", "예약이 완료되었습니다.");
		model.addAttribute("url", request.getContextPath()+"/reserv/reservList");
		
		return "common/resultAlert";
	}
	
	//회원 예약 리스트
	@RequestMapping("/reserv/reservList")
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
		
		return "reservListUser";
	}
	
	//회원 예약 상세
	@RequestMapping("/reserv/reservDetail")
	public String userReservListDetail(@RequestParam int reservation_num, Model model) {
		
		ReservHallVO detail = new ReservHallVO();
		detail = reservService.selectReservListByReservNum(reservation_num);
		
		detail.setReservation_date(reservService.selectReservDateList(reservation_num));
		
		int weekendCount = 0;
	    int weekdayCount = 0;
		
		for (Date date : reservService.selectReservDateList(reservation_num)) {
            // Calendar 객체 생성 및 날짜 설정
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(date);

            // 주말이면 weekendCount 증가, 아니면 weekdayCount 증가
            if (isWeekend(calendar)) {
                weekendCount++;
            } else {
                weekdayCount++;
            }
        }
		
		//결제정보
		PaymentHallVO payment = reservService.selectPaymentHall(reservation_num);
		
		model.addAttribute("payment", payment);
		model.addAttribute("detail", detail);
		model.addAttribute("result", weekendCount*400000+weekdayCount*300000);
		
		return "reservDetail";
	}
	
	@RequestMapping("/reserv/file")
	public ModelAndView download(@RequestParam int reservation_num, @RequestParam int file_num,
			                     HttpServletRequest request) {
		ReservHallVO vo = reservService.selectReservListByReservNum(reservation_num);
		
		ModelAndView mav = new ModelAndView();
		//파일을 절대경로에서 읽어들여 byte[]로 변환
		byte[] downloadFile = null;
		if(file_num==1) {
			downloadFile = FileUtil.getBytes(request.getServletContext().getRealPath("/upload")+"/"+vo.getReservation_form1());
			mav.addObject("filename", vo.getReservation_form1());
		}
		else if(file_num==2) {
			downloadFile = FileUtil.getBytes(request.getServletContext().getRealPath("/upload")+"/"+vo.getReservation_form2());
			mav.addObject("filename", vo.getReservation_form2());
		}
		else if(file_num==3) {
			downloadFile = FileUtil.getBytes(request.getServletContext().getRealPath("/upload")+"/"+vo.getReservation_form3());
			mav.addObject("filename", vo.getReservation_form3());
		}
		
		
		mav.addObject("downloadFile", downloadFile);
		
		mav.setViewName("downloadView");
		
		
	
		return mav;
	}
	
	//관리자 예약목록
	@RequestMapping("/reserv/reservListAdmin")
	public ModelAndView reservListAdmin(@RequestParam(value="pageNum", defaultValue = "1") int currentPage) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		int count = reservService.selectReservListAdminCount();
		
		PageUtil page = new PageUtil(currentPage, count, 20, 10, "reservListAdmin");
		
		List<ReservHallVO> list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = reservService.selectReservListAdmin(map);
		}
		
		for(ReservHallVO reserv : list) {
			List<Date> date = new ArrayList<>();
			date = reservService.selectReservDateList(reserv.getReservation_num());
			reserv.setReservation_date(date);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("reservListAdmin");
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		
		return mav;
	}
	
	@RequestMapping("/reserv/reservDetailAdmin")
	public String AdminReservListDetail(@RequestParam int reservation_num, Model model) {
		
		int weekendCount = 0;
	    int weekdayCount = 0;
		
		ReservHallVO detail = new ReservHallVO();
		detail = reservService.selectReservListByReservNum(reservation_num);
		
		detail.setReservation_date(reservService.selectReservDateList(reservation_num));
		
		for (Date date : reservService.selectReservDateList(reservation_num)) {
            // Calendar 객체 생성 및 날짜 설정
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(date);

            // 주말이면 weekendCount 증가, 아니면 weekdayCount 증가
            if (isWeekend(calendar)) {
                weekendCount++;
            } else {
                weekdayCount++;
            }
        }
		
		model.addAttribute("detail", detail);
		model.addAttribute("result", weekendCount*400000+weekdayCount*300000);
		
		
		return "reservDetailAdmin";
	}
	//주말여부 확인
	private boolean isWeekend(Calendar calendar) {
        int dayOfWeek = calendar.get(Calendar.DAY_OF_WEEK);
        return dayOfWeek == Calendar.SATURDAY || dayOfWeek == Calendar.SUNDAY;
    }
	
	//결제 페이지
	@GetMapping("/reserv/reservPayment")
	public String reservPayment(@RequestParam int reservation_num, HttpSession session, Model model, HttpServletRequest request) {
		ReservHallVO db_hall = reservService.selectReservListByReservNum(reservation_num);
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user.getMem_num()!=db_hall.getMem_num()) {
			model.addAttribute("message", "잘못된 접근입니다.");
			model.addAttribute("url", request.getContextPath()+"/reserv/list");
			
			return "common/resultAlert";
		}
		ReservHallVO date = new ReservHallVO();
		date.setReservation_date(reservService.selectReservDateList(reservation_num));
		PaymentHallVO payment = reservService.selectPaymentHall(reservation_num);
		
		int weekendCount = 0;
	    int weekdayCount = 0;
		
		ReservHallVO detail = new ReservHallVO();
		detail = reservService.selectReservListByReservNum(reservation_num);
		
		detail.setReservation_date(reservService.selectReservDateList(reservation_num));
		
		for (Date dd : reservService.selectReservDateList(reservation_num)) {
            // Calendar 객체 생성 및 날짜 설정
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(dd);

            // 주말이면 weekendCount 증가, 아니면 weekdayCount 증가
            if (isWeekend(calendar)) {
                weekendCount++;
            } else {
                weekdayCount++;
            }
        }
		
		
		model.addAttribute("reserv", db_hall);
		model.addAttribute("payment", payment);
		model.addAttribute("date", date);
		model.addAttribute("weekendCount", weekendCount);
		model.addAttribute("weekdayCount", weekdayCount);
		
		return "reservPayment";
	}
	
	//대관일정
	@RequestMapping("/reserv/reservSchedule")
	public String reservSchedule() {
		
		return "reservSchedule";
	}
	
	//결제 내역 확인
	
}






















