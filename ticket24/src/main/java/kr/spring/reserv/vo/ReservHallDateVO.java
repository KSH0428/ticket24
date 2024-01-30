package kr.spring.reserv.vo;

import java.sql.Date;


import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ReservHallDateVO {
	private int reservation_num;
	private Date reservation_date;
}
