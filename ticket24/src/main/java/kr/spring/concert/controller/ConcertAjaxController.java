package kr.spring.concert.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.concert.service.ConcertService;
import kr.spring.concert.vo.ConcertRoundVO;
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
}
