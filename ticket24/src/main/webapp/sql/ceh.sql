create table member(
 mem_num number not null,
 mem_id varchar2(12) unique not null,
 mem_nickname varchar2(30),
 mem_auth number(1) default 1 not null, --0:탈퇴회원,1:실버,2:골드,3:플래티넘,9:관리자
 constraint member_pk primary key (mem_num)
 );

create table member_detail(
 mem_num number not null,
 mem_au_id varchar2(36) unique,
 mem_name varchar2(30) not null,
 mem_passwd varchar2(35) not null,
 mem_phone varchar2(15) not null,
 mem_email varchar2(50) not null,
 mem_zipcode varchar2(5) not null,
 mem_address1 varchar2(90) not null,
 mem_address2 varchar2(90) not null,
 mem_filename varchar2(200),
 mem_reg_date date default sysdate not null,
 mem_modify_date date,
 constraint member_detail_pk primary key (mem_num),
 constraint member_detail_fk foreign key (mem_num) references member (mem_num)
);

create sequence member_seq;

create table member_point(
 pt_num number not null,
 mem_num number not null,
 pt_amount varchar2(50) not null,
 pt_sum varchar2(50) not null,
 pt_status number(1) not null,
 pt_content varchar2(100) not null,
 pt_reg_date date default sysdate not null,
 reserve_num number not null,
 event_num number not null,	
 constraint member_point_pk primary key (pt_num),
 constraint member_point_fk1 foreign key (mem_num) references member (mem_num),
 constraint member_point_fk2 foreign key (reserve_num) references concert_reservation (reserve_num),
 constraint member_point_fk3 foreign key (event_num) references event (event_num)
);

create sequence member_point_seq;