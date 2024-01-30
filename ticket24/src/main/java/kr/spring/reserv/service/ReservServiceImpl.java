package kr.spring.reserv.service;

import java.sql.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.reserv.dao.ReservMapper;
import kr.spring.reserv.vo.ReservHallDateVO;
import kr.spring.reserv.vo.ReservHallVO;

@Service
@Transactional
public class ReservServiceImpl implements ReservService{
	@Autowired
	private ReservMapper reservMapper;
	
	@Override
	public void insertReserv(ReservHallVO reservHallVO) {
		reservHallVO.setReservation_num(reservMapper.selectReservNum());
		reservMapper.insertReserv(reservHallVO);
		
		ReservHallDateVO dateVO = new ReservHallDateVO();
		dateVO.setReservation_num(reservHallVO.getReservation_num());
		List<Date> date = reservHallVO.getReservation_date();
		
		
		for (Date d : date) { // 대괄호 '['와 ']'를 제거 String dateString =
			dateVO.setReservation_date(d);
			reservMapper.insertReservDate(dateVO);
		}
	}

	@Override
	public List<String> selectReservDate() {
		return reservMapper.selectReservDate();
	}

	@Override
	public List<ReservHallVO> selectReservList(int mem_num) {
		return reservMapper.selectReservList(mem_num);
	}

	@Override
	public List<Date> selectReservDateList(int reservation_num) {
		return reservMapper.selectReservDateList(reservation_num);
	}

	@Override
	public ReservHallVO selectReservListByReservNum(int reservation_num) {
		return reservMapper.selectReservListByReservNum(reservation_num);
	}

}
