package kr.spring.mdcart.service;

import java.util.List;
import java.util.Map;


import kr.spring.mdcart.vo.MdCartVO;

public interface MdCartService {
		//카트 등록
		public void insertCart(MdCartVO cart);
		//회원번호(mem_num)별 총구매액
		public int getTotalByMem_num(int mem_num);
		//카트목록
		public List<MdCartVO> selectList(int mem_num);
		//장바구니 상세
		public MdCartVO selectCart(MdCartVO cart);
		//장바구니 수정(개별 상품 수량 수정)
		public void updateCart(MdCartVO cart);
		//장바구니 상품번호와 회원번호별 수정
		public void updateCartByMd_num(MdCartVO cart);
		//카트 삭제
		public void deleteCart(int md_cart_num); 
}
