package kr.spring.mdorder.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;

import kr.spring.mdorder.service.MdOrderService;
import kr.spring.mdorder.vo.MdOrderVO;
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
	
	
	
	
	
	
	
	
	
}
