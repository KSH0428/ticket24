package kr.spring.concert.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ConcertRoundVO {
	private int concert_num;
	private int c_round_num;
	private String year;
	private String month;
	private String day;
	private String concert_time; 
}
