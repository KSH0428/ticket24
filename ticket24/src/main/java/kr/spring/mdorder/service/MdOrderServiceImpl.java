package kr.spring.mdorder.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.mdorder.dao.MdOrderMapper;
import kr.spring.mdorder.vo.MdOrderDetailVO;
import kr.spring.mdorder.vo.MdOrderVO;

@Service
@Transactional
public class MdOrderServiceImpl implements MdOrderService{

	@Autowired
	private MdOrderMapper mdOrderMapper;
	
	@Override
	public void insertOrder(MdOrderVO order, List<MdOrderDetailVO> orderDetailList) {
		mdOrderMapper.insertOrder(order, orderDetailList);
		
	}

	@Override
	public MdOrderVO selectPorder(int md_order_num) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateOPayment(MdOrderVO mdOrderVO) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public int getOrderCountByMem_num(String keyfield, String keyword, int mem_num) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<MdOrderVO> getListOrderByMem_num(int start, int end, String keyfield, String keyword, int mem_num) {
		// TODO Auto-generated method stub
		return null;
	}

}
