package kr.spring.mdcart.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.md.dao.MdMapper;
import kr.spring.md.vo.MdVO;
import kr.spring.mdcart.dao.MdCartMapper;
import kr.spring.mdcart.service.MdCartService;
import kr.spring.mdcart.vo.MdCartVO;
import kr.spring.member.vo.MemberVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class MdCartController {
	@Autowired
	private MdCartService mdCartService;

	/*
	 * ============================== 
	 * 자바빈(VO) 초기화 
	 * ==============================
	 */
	@ModelAttribute
	public MdCartVO initCommand() {
		return new MdCartVO();
	}

	/*
	 * ================================= 
	 * 장바구니 등록 
	 * =================================
	 */
	@PostMapping("/mdCart/addCart")
	public String insertCart(
			@RequestParam int md_num,
			MdCartVO cartVO, HttpSession session, Model model, HttpServletRequest request) {
		
		log.debug("<<장바구니 등록 MdCartVO >> : " + cartVO);

		MemberVO user = (MemberVO) (session.getAttribute("user"));

		cartVO.setMem_num(user.getMem_num());
		model.addAttribute("message", "장바구니 추가가 완료되었습니다");
		model.addAttribute("url" ,request.getContextPath()+"/mdCart/cartList");
		mdCartService.insertCart(cartVO);
		
		return "common/resultAlert";
	}
	

	/*
	 * ================================= 
	 * 장바구니 목록 
	 * =================================
	 */
	@RequestMapping("/mdCart/cartList")
	@ResponseBody
	public ModelAndView getList(
			HttpSession session) {

		MemberVO user = (MemberVO) (session.getAttribute("user"));
		//int mem_num = (int)session.getAttribute("mem_num");
		
		MdVO md = (MdVO) (session.getAttribute("md"));
		
		Map<String, Object> map = new HashMap<String, Object>();
		List<MdCartVO> list = mdCartService.selectList(user.getMem_num());
		//장바구니 전체 금액 호출
		int getTotal = mdCartService.getTotalByMem_num(user.getMem_num());
		//장바구니 전체 금액에 따라 배송비 구분
		//배송료(6만 원 이샹=> 무료, 미만=> 3000원)
		int fee = getTotal >= 60000 ? 0 : 3000;
		
		
		ModelAndView mav = new ModelAndView();
		//map.put("count", list.size()); //장바구니 상품의 유무
		map.put("getTotal", getTotal); //장바구니 전체 금액
		map.put("fee", fee); //배송금액
		map.put("allSum", getTotal+fee);//주문 상품 전체 금액
		mav.setViewName("cartList"); //view(jsp)의 이름 저장
		mav.addObject("map",map); //map 변수 저장
		mav.addObject("list", list);
		
		return mav;
}

	/*
	 * ================================= 
	 * 장바구니 수정(수량 변경)
	 *  =================================
	 */
	@RequestMapping("/mdCart/updateCart")
	public String update(
				@RequestParam int[] order_quantity,
				@RequestParam int[] md_num, HttpSession session) {
		String mem_num = (String) session.getAttribute("mem_num");
		//레코드의 갯수 만큼 반복문 실행
		for(int i=0; i<md_num.length;i++) {
			MdCartVO vo = new MdCartVO();
			vo.setMem_num(i);
			vo.setOrder_quantity(i);
			vo.setMd_num(i);
			mdCartService.updateCart(vo);
		}
		
		
		
		return "redirect:/mdCart/cartList";
	}
	
	 

	/*
	 * ================================= 
	 * 장바구니 삭제 
	 * =================================
	 */
	@RequestMapping("/mdCart/deleteCart")
	public String delete(@RequestParam int md_cart_num) {
		mdCartService.deleteCart(md_cart_num);
		return "redirect:/mdCart/cartList";
	}
	
	

	  }
