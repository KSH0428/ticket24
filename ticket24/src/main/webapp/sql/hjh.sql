--md 등록
create table md(
	md_num number not null,
	md_name varchar2(30) not null,
	md_price number(10) not null,
	md_quantity number(5) not null,
	md_photo1 varchar2(60) not null,
	md_photo2 varchar2(60) not null,
	md_detail clob not null,
	md_regdate date default sysdate not null,
	md_mdate date,
	md_status number(1) not null,
	constraint md_pk primary key (md_num)
);

create sequence md_seq;
