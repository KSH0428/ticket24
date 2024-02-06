package kr.spring.mdcart.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import kr.spring.mdcart.vo.MdCartVO;

@Mapper
public interface MdCartMapper {

	//카트 등록
	@Insert("INSERT INTO md_cart (md_cart_num,md_num,order_quantity,mem_num) VALUES (md_cart_seq.nextval,#{md_num},#{order_quantity},#{mem_num})")
	public void insertCart(MdCartVO cart);
	//회원번호(mem_num)별 총구매액
	public int getTotalByMem_num(int mem_num);
	//카트목록
	public List<MdCartVO> selectList(int mem_num);
	//장바구니 상세
	//@Select("SELECT * FROM md_cart JOIN md USING(md_num) WHERE md_cart_num=#{md_cart_num}")
	public MdCartVO selectCart(int md_num, int mem_num);
	//장바구니 수정(개별 상품 수량 수정)
	public void updateCart(MdCartVO cart);
	//장바구니 상품번호와 회원번호별 수정
	public void updateCartByMd_num(MdCartVO cart);
	//카트 삭제
	@Delete("DELETE FROM md_cart WHERE md_cart_num=#{md_cart_num}")
	public void deleteCart(int md_cart_num); 
	
}
