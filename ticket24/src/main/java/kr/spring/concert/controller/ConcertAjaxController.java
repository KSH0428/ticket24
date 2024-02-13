package kr.spring.concert.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.concert.service.ConcertService;
import kr.spring.concert.vo.ConcertRoundVO;
import kr.spring.concert.vo.ConcertSeatVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class ConcertAjaxController {
	@Autowired
	private ConcertService concertService;
	
	//콘서트 회차 정보
	@RequestMapping("/concert/concertRound")
	@ResponseBody
	public List<ConcertRoundVO> getConcertRound(int concert_num) {
		
		List<ConcertRoundVO> round = concertService.selectRoundList(concert_num);
		log.debug("<<콘서트 회차 정보 가져오기 >> : " + round);
		return round;
	}
	
	
	//콘서트 해당 회차 좌석 정보
	@RequestMapping("/concert/concertRemainingSeats")
	@ResponseBody
	public int getRemainingSeats(int c_round_num) {
		
		int remainingSeats = concertService.selectC_roundRemainingSeats(c_round_num);
		log.debug("<<콘서트 회차 남은 자리 수>> : " + remainingSeats);
		return remainingSeats;
	}
	
	//콘서트 좌석 예약 가능 여부
	@RequestMapping("/concert/concertSeatListInfo")
	@ResponseBody
	public List<ConcertSeatVO> getConsertSeatinfo(int concert_num, int c_round_num){
		List<ConcertSeatVO> seatInfo = concertService.selectSeatsList(concert_num, c_round_num);
		log.debug("<<콘서트 해당 회차 좌석 정보 가져오기>");
		log.debug("concert_num : " + concert_num + ", c_round_num : " + c_round_num);
		
		return seatInfo;
	}
}
