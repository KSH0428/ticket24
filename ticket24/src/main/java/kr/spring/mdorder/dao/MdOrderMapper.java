package kr.spring.mdorder.dao;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import kr.spring.mdorder.vo.MdOrderDetailVO;
import kr.spring.mdorder.vo.MdOrderVO;

public interface MdOrderMapper {

	//주문(결제)등록
	public void insertOrder(MdOrderVO order, List<MdOrderDetailVO> orderDetailList);
	
	//주문(결제) 조회
	@Select("SELECT * FROM md_order WHERE md_order_num=#{md_order_num}")
	public MdOrderVO selectPorder(int md_order_num);
	
	//결제 완료
	public void updateOPayment(MdOrderVO mdOrderVO);
	
	//사용자 - 전체 주문 개수/검색 주문 개수
	public int getOrderCountByMem_num(String keyfield, String keyword,int mem_num);
	
	//사용자 - 전체 주문 목록/검색 주문 목록
	public List<MdOrderVO> getListOrderByMem_num(int start, int end, String keyfield, String keyword, int mem_num);
	
	
	
	/*
	 * //관리자 - 전체 주문 개수/검색 주문 개수 
	 * public int getOrderCount(String keyfield, String,keyword);
	 * 
	 *  //관리자 - 전체 주문 목록/검색 주문 목록
	 *   public List<MdOrderVO> getListOrder(int
	 * start, int end, String keyfield, String keyword); 
	 * 
	 * 
	 * 
	 * 
	 * //개별 상품 목록
	 *  public List<MdOrderDetailVO> getListOrderDetail(int md_order_num);
	 * 
	 * //주문 삭제(삭제시 재고를 원상 복귀시키지 않음, 주문취소일 때 원상 복귀)
	 * 
	 *  //관리자/사용자 - 주문상세
	 *   public MdOrderVO getOrder(int md_order_num);
	 * 
	 * 
	 * 
	 * //관리자/사용자 - 배송지정보 수정 
	 * public void updateOrder(MdOrderVO order);
	 * 
	 * 
	 * //관리자 - 배송상태 수정 
	 * public void updateOrderStatus(MdOrderVO order);
	 * 
	 * //사용자 - 주문취소 
	 * public void updateOrderCancel(int md_order_num);
	 * 
	 */
	
}
