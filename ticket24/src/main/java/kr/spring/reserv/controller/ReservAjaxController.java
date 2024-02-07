package kr.spring.reserv.controller;


import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.member.vo.MemberVO;
import kr.spring.reserv.service.ReservService;
import kr.spring.reserv.vo.PaymentHallVO;
import kr.spring.reserv.vo.ReservHallDateVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class ReservAjaxController {
	@Autowired
	private ReservService reservService;
	
	
	
	/*==========================
	 * 예약 상태 변경
	 *=========================*/
	@RequestMapping("/reserv/updateStatus")
	@ResponseBody
	public Map<String, String> reservDate(int reservation_num, int reservation_status, HttpSession session){
		log.debug("<<update status>> : " + reservation_status);
		Map<String, String> mapAjax = new HashMap<String, String>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		if(user==null) {
			mapAjax.put("result", "logout");
		}else {
			reservService.updateReservStatus(reservation_num, reservation_status);
			mapAjax.put("result", "success");
		}
		
		
		return mapAjax;
	}
	
	//결제 ajax
	@RequestMapping("/reserv/updatePayment")
	@ResponseBody
	public Map<String, String> updatePayment(PaymentHallVO payment, HttpSession session){
		MemberVO user = (MemberVO)session.getAttribute("user");
		log.debug("<<결제 ajax vo>> : " + payment);
		PaymentHallVO userPayment = reservService.selectPaymentHall(payment.getReservation_num());
		//email 추가할것!!!
		userPayment.setPayment_name(payment.getPayment_name());
		userPayment.setPayment_phone(payment.getPayment_phone());
		userPayment.setPayment_email(payment.getPayment_email());
		userPayment.setPayment_method(payment.getPayment_method());
		userPayment.setMerchant_uid(payment.getMerchant_uid());
		userPayment.setImp_uid(payment.getImp_uid());
		
		java.util.Date date = new java.util.Date(Long.parseLong(payment.getPaid_at())*1000);
		Date sqlDate = new Date(date.getTime());
		
		userPayment.setPayment_date(sqlDate);
		
		log.debug("<<결제 ajax sql>> : " + userPayment);
		Map<String, String> mapAjax = new HashMap<String, String>();
		
		if(user==null) {
			mapAjax.put("result", "logout");
		}else {
			reservService.updatePayment(userPayment);
			mapAjax.put("result", "success");
		}
		
		return mapAjax;
	}
	
	//full calendar 일정 불러오기
	 @GetMapping("/calendar-admin")
	 @ResponseBody
	 public List<Map<String, Object>> monthPlan() {
		 List<ReservHallDateVO> list = reservService.selectReservSchedule();

		 List<Map<String, Object>> jsonList = new ArrayList<>();

		 for (int i = 0; i < list.size(); i++) {
			 Map<String, Object> event = new HashMap<>();
			 
			 event.put("title", "[대관예약]"+list.get(i).getReservation_name());
			 
			 int j = 0;
			 log.debug("<<tolocaldate + 1>> : " + list.get(i).getReservation_date().toLocalDate().plusDays(1));
			 log.debug("<<tolocaldate>> : " + list.get(i).getReservation_date().toLocalDate());
			 while(i + j + 1 < list.size()&&list.get(i).getReservation_date().toLocalDate().plusDays(1+j).getDayOfMonth()
					 ==list.get(i+1+j).getReservation_date().toLocalDate().getDayOfMonth()&&
					 list.get(i).getReservation_num()==list.get(i+1+j).getReservation_num()){
				 j++;
			 }
			 event.put("start", list.get(i).getReservation_date());
			 event.put("end", list.get(i+j).getReservation_date().toLocalDate().plusDays(1));
			 event.put("backgroundColor", "orange");
			 event.put("borderColor", "#f59042");
			 
			 i += j;
			 jsonList.add(event);
			 log.debug("<<일정 불러오기 event> : " + event);
			 
		 }

		 return jsonList;
	 }
}
