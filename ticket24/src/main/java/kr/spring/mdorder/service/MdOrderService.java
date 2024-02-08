package kr.spring.mdorder.service;

import java.util.List;

import org.apache.ibatis.annotations.Delete;

import kr.spring.mdorder.vo.MdOrderDetailVO;
import kr.spring.mdorder.vo.MdOrderVO;

public interface MdOrderService {

		//주문(결제)등록
		public void insertOrder(MdOrderVO order, List<MdOrderDetailVO> orderDetailList);
		
		//주문(결제) 조회
		public MdOrderVO selectPorder(int md_order_num);
		
		//결제 완료
		public void updateOPayment(MdOrderVO mdOrderVO);
		
		//사용자 - 전체 주문 개수/검색 주문 개수
		public int getOrderCountByMem_num(String keyfield, String keyword,int mem_num);
		
		//사용자 - 전체 주문 목록/검색 주문 목록
		public List<MdOrderVO> getListOrderByMem_num(int start, int end, String keyfield, String keyword, int mem_num);
		
		//사용자 - 주문취소 
		public void updateOrderCancel(int md_order_num);

}
