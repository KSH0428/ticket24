package kr.spring.reserv.controller;


import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.member.vo.MemberVO;
import kr.spring.reserv.service.ReservService;
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
			mapAjax.put("result", "success");
			reservService.updateReservStatus(reservation_num, reservation_status);
		}
		
		
		return mapAjax;
	}
}
