--콘서트 (콘서트 작성 이후 연극, 뮤지컬 테이블 작성)
create table concert(
 concert_num number not null,
 concert_title varchar2(60) not null,
 start_date date not null,
 end_date date not null,
 concert_hall varchar2(20) not null,
 monopoly number not null,
 img_poster varchar2(200) not null,
 constraint concert_pk primary key (concert_num)
);
create sequence concert_seq; -- concert_num 시퀀스
--콘서트 상세
create table concert_detail(
 concert_num number not null,
 grade number not null,
 viewing_time date not null,
 cast varchar2(50) not null,
 price_vip varchar2(6),	-- 좌석 가격. 값이 null이면 해당 좌석은 없음
 price_r varchar2(6),
 price_s varchar2(6),
 price_a varchar2(6),
 price_standing varchar2(6),
 delivery_date date, -- 티켓 배송일. null이면 현장 수령
 likes number(3) not null, -- 좋아요
 image_1 varchar2(150) not null, -- 콘서트 상세 소개 이미지(3개까지 필수)
 image_2 varchar2(150) not null,
 image_3 varchar2(150) not null,
 image_4 varchar2(150),
 image_5 varchar2(150),
 constraint concert_detail_fk foreign key (concert_num) references concert (concert_num)
 ON DELETE CASCADE -- 해당 컬럼이 삭제되면 참조하는 자식 테이블의 컬럼도 삭제
);
--공연 회차 정보
create table concert_round(
 concert_num number not null,
 c_round_num number not null, -- 최소 1회차는 등록해야 한다.
 concert_time date not null,
 remaining_vip number(3), -- 남은 좌석수
 remaining_r number(3),
 remaining_s number(3),
 remaining_a number(3),
 remaining_b number(3),
 remaining_st number(3),
 seating_vip number(3), -- 할당된 좌석수
 seating_r number(3),
 seating_s number(3),
 seating_a number(3),
 seating_b number(3),
 seating_st number(3),
 constraint concert_round_fk foreign key (concert_num) references concert (concert_num)
 ON DELETE CASCADE, -- 해당 컬럼이 삭제되면 참조하는 자식 테이블의 컬럼도 삭제 
 constraint concert_round_pk primary key (c_round_num) 
);
--공연 좌석 정보
create table concert_seat(
 concert_num number not null,
 c_round_num number not null,
 seat_id varchar2(3) not null, -- 좌석 번호
 seat_grade number not null, -- 좌석 등급( 0:VIP 1:R 2:S 3:A 4:B 5:Standing) 
 status number not null, -- 예약 상태(0 : 선택 가능 1 : 예약 상태 2 : 결제 완료) 예약 상태나 결제 완료일 경우 아래 테이블과 조인하여 회원 id를 구한다.
 constraint concert_seat_fk1 foreign key (concert_num) references concert (concert_num)
 ON DELETE CASCADE, -- 해당 컬럼이 삭제되면 참조하는 자식 테이블의 컬럼도 삭제
 constraint concert_seat_fk2 foreign key (c_round_num) references concert_round (c_round_num)
);
--공연 예약 테이블
create table concert_reservation(
 reserve_num number not null,
 concert_num number not null,
 c_round_num number not null,
 seat_id varchar2(3) not null, -- 예약한 좌석 번호
 mem_num number not null, -- 예약한 회원 번호
 price number(10) not null,
 payment_status number not null, -- 지불 여부(0:미지불 1:지불완료 2:취소)
 reserve_date date, --주문날짜. 관람 시간은 concert_num을 통해 얻어온다.
 constraint concert_reservation_pk primary key (reserve_num),
 constraint concert_reservation_fk1 foreign key (concert_num) references concert (concert_num),
 constraint concert_reservation_fk2 foreign key (c_round_num) references concert_round (c_round_num),
 constraint concert_reservation_fk3 foreign key (mem_num) references member (mem_num)
);
create sequence concet_reserve_seq; -- 예약 시퀀스
--후기 테이블
