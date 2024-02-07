package kr.spring.mdorder.controller;

import java.sql.Date;
import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;

import kr.spring.mdorder.service.MdOrderService;
import kr.spring.mdorder.vo.MdOrderVO;
import kr.spring.member.vo.MemberVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class MdOrderController {
	@Autowired
	private MdOrderService mdOrderService;
	
	//자바빈(VO) todtjd
	@ModelAttribute
	public MdOrderVO initCommand() {
		return new MdOrderVO();
	}
	
	/*=================================
	 * 주문 등록
	 *=================================*/
	//결제 페이지
		@GetMapping("/mdOrder/mdOrderPayment")
		public String mdOrderPayment(
				@RequestParam int md_order_num, Model model,
				HttpSession session, HttpServletRequest request) {
			
			//MdOrderVO db_mem = mdOrderService.selectPorder(md_order_num);
			//MemberVO user = (MemberVO)session.getAttribute("user");
			
			return "";
		}
		
		
		
		
		
		
		
		
		
		/*
, Model model, HttpServletRequest request) {
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
		
	*/
	
	
	
	
	
	
	
}
