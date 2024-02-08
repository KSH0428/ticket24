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
		return mdOrderMapper.selectPorder(md_order_num);
	}

	@Override
	public void updateOPayment(MdOrderVO mdOrderVO) {
		mdOrderMapper.updateOPayment(mdOrderVO);
		
	}

	@Override
	public int getOrderCountByMem_num(String keyfield, String keyword, int mem_num) {
		return mdOrderMapper.getOrderCountByMem_num(keyfield, keyword, mem_num);
	}

	@Override
	public List<MdOrderVO> getListOrderByMem_num(int start, int end, String keyfield, String keyword, int mem_num) {
		return mdOrderMapper.getListOrderByMem_num(start, end, keyfield, keyword, mem_num);
	}

	@Override
	public void updateOrderCancel(int md_order_num) {
		mdOrderMapper.updateOrderCancel(md_order_num);
		
	}

}
