package kr.spring.reserv.controller;


import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class ReservAjaxController {
	
	/*==========================
	 * 예약 날짜 전송
	 *=========================*/
	@PostMapping("/reserv/reservDate")
	@ResponseBody
	public Map<String, String> reservDate(@RequestBody List<String> dateArray){
			
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSSX");
	    for (String dateString : dateArray) {
	            LocalDate localDate = LocalDate.parse(dateString, formatter);
	            // localDate를 사용하여 원하는 작업 수행
	            log.debug(localDate.toString());
	    }
	      	Map<String, String> mapJson = new HashMap<String, String>();
	      	mapJson.put("result", "success");
	        log.debug(dateArray.toString());
	        return mapJson;
	}
}
