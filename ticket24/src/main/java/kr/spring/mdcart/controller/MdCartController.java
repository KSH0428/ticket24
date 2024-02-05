package kr.spring.mdcart.controller;

import java.io.IOException;
import java.util.Collections;
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
	 * ============================== 자바빈(VO) 초기화 ==============================
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
	@RequestMapping("/mdCart/addCart")
	@ResponseBody
	public void insertCart(
			@RequestParam int md_num,
			MdCartVO cartVO, HttpSession session) {
		
		log.debug("<<장바구니 등록 MdCartVO >> : " + cartVO);

		MemberVO user = (MemberVO) (session.getAttribute("user"));

		cartVO.setMem_num(user.getMem_num());

		mdCartService.insertCart(cartVO);
		
	}

	/*
	 * ================================= 
	 * 장바구니 목록 
	 * =================================
	 */
	@RequestMapping("/mdCart/cartList")
	@ResponseBody
	public Map<String, Object> getList(
			@RequestParam int md_cart_num, 
			HttpSession session) {

		List<MdCartVO> list = null;
		list = mdCartService.selectList(md_cart_num);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("md_cart_num", md_cart_num);
		//map.put("list", list);

		return map;
}

	/*
	 * ================================= 
	 * 회원번호별 총 구매액
	 * =================================
	 */

	/*
	 * ================================= 
	 * 장바구니 상세
	 *  =================================
	 */

	/*
	 * ================================= 
	 * 장바구니 수정
	 *  =================================
	 */
	/*
	 * @RequestMapping("/mdCart/updateCart")
	 * 
	 * @ResponseBody public Map<String,String> modifyMd(MdCartVO mdCartVO,
	 * HttpSession session, HttpServletRequest request){
	 * log.debug("<<장바구니 수정 MdCartVO>> : " + mdCartVO);
	 * 
	 * Map<String,String> mapJson = new HashMap<String,String>();
	 * 
	 * MemberVO user = (MemberVO)session.getAttribute("user"); MdCartVO db_cart =
	 * mdCartService.selectCart(mdCartVO.getMem_num()); if(user==null) { //로그인이 되지
	 * 않은 경우 mapJson.put("result", "logout"); }else if(user!=null &&
	 * user.getMem_num()==db_cart.getMem_num()) { //로그인한 회원번호와 작성자 회원번호 일치 //댓글 수정
	 * mdCartService.updateCart(db_cart); mapJson.put("result", "success"); }else {
	 * //로그인한 회원번호와 작성자 회원번호 불일치 mapJson.put("result", "wrongAccess"); } return
	 * mapJson; }
	 * 
	 */

	/*
	 * ================================= 장바구니 삭제 =================================
	 */

}
