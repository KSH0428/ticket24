package kr.spring.concert.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ConcertVO {
	private int concert_num;
	private String concert_title;
	private String period;
	private String concert_hall;
	private String monopoly;
	private String img_poster;
}
