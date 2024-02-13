package kr.spring.concert.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
public class ConcertSeatVO {
	private int concert_num;
	private int c_round_num;
	private int seat_num;
	private int status;
}
