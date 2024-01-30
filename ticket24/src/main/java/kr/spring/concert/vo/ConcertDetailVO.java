package kr.spring.concert.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ConcertDetailVO {
	private int concert_num;
	private String grade;
	private String viewing_time;
	private String casting;
	private String c_round_1;
	private String c_round_2;
	private String image_1 = "null";
	private String image_2 = "null";
	private String image_3 = "null";
	private String image_4 = "null";
	private String image_5 = "null";
	private String image_6 = "null";
	private String image_7 = "null";
	
	//concertVO에서 가져와야 하는 정보
	private String img_poster;
	private String concert_title;
	private String period;	
	private String monopoly;	
	private String concert_hall;

}
