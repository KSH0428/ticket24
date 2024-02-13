package kr.spring.mdorder.controller;

import java.sql.Date;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import ch.qos.logback.classic.Logger;
import kr.spring.mdcart.vo.MdCartVO;
import kr.spring.mdorder.service.MdOrderService;
import kr.spring.mdorder.vo.MdOrderDetailVO;
import kr.spring.mdorder.vo.MdOrderVO;
import kr.spring.member.vo.MemberVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class MdOrderController {
	@Autowired
	private MdOrderService mdOrderService;
	
	//자바빈(VO) 생성
	@ModelAttribute
	public MdOrderVO initCommand() {
		return new MdOrderVO();
	}
	
	 @RequestMapping("/mdOrder/orderView")
	  public String orderView(int md_cart_num, Model model) throws Exception{
		  List<MdOrderVO> orderList = new ArrayList<>(); 
		 //for(int i=0; i < (MdCartVO.getMd_cart_num()).length; i++){
				  
				//  .getItem_no()).length; i++) {
			
			  MdOrderVO VO = new MdOrderVO ();
			  //VO.setMd_item_name(mdOrderVO.getMd_item_name()[i]);
			  
			  
			 // VO.setOrder_item_option(orderItemVO.getItem_option()[i]);
			 // VO.setOrder_item_price(orderItemVO.getItem_price()[i]);
			 // VO.setOrder_option_no(orderItemVO.getOption_no()[i]);
			 // VO.setOrder_item_no(orderItemVO.getItem_no()[i]);
			 // VO.setOrder_select_vol(orderItemVO.getSelect_vol()[i]);
			  orderList.add(VO);

		 // }
	/*
	 * model.addAttribute("order", orderList); model.addAttribute("md_order_total",
	 * md_order_total);
	 * 
	 * if(session.getAttribute("member") != null) { MemberVO memberVO = (MemberVO)
	 * session.getAttribute("member"); } return "/mdOrder/orderView"; }
	 */
	
	
	
	//정상적인 주문
	//장바구니에 담겨있는 상품정보 반환
	//주문 상품의 대표 상품명 생성
	//개별 상품정보 담기
	//주문정보 담기
	/*
	 * @RequestMapping("/mdOrder/mdOrderPayment") public String
	 * orderInsert(MdOrderVO mdOrderVO, MdOrderDetailVO mdOrderDetailVO) {
	 */	/*
		   logger.info("orderVOtest="+merchant_uid);
			  String ckid = RandomStringUtils.randomNumeric(8);
			  int orderedNo = Integer.parseInt(ckid);
			  orderedVO.setOrdered_no(orderedNo);
			  mainService.orderInsert(orderedVO, itemInsertVO);
			  
		  }
			 * 
			 */
		
		return "redirect:/main/cartList";
	}
	
	
	
	
	
	//결제 페이지
		@GetMapping("/mdOrder/mdOrderPayment")
		public String mdOrderPayment(
				@RequestParam int md_order_num, Model model,
				HttpSession session, HttpServletRequest request) {
			
		MdOrderVO db_mem = mdOrderService.selectPorder(md_order_num);
		MemberVO user = (MemberVO)session.getAttribute("user");
			
		if(user.getMem_num()!=db_mem.getMem_num()) {
			model.addAttribute("message", "잘못된 접근입니다.");
			model.addAttribute("url", request.getContextPath()+"/md/mdList");
			
			return "common/resultAlert";
		}
		
		model.addAttribute("moOrder", db_mem);
		
			return "/mdOrder/mdOrderPayment";
		}
		
		//결제 내역 확인
		@RequestMapping("/mdOrder/paymentDetail")
		public String paymentDetail(int md_order_num, Model model) {
			MdOrderVO payment = mdOrderService.selectPorder(md_order_num);
			
			model.addAttribute("payment", payment);
			
			return "paymentDetail";
		}
		
		//신청 취소
		
		
		
		
	
}
