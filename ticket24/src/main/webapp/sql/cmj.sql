--공연정보
CREATE TABLE show_data (
    mt20id VARCHAR2(30) PRIMARY KEY,
    prfnm VARCHAR2(300),
    prfpdfrom DATE,
    prfpdto DATE,
    fcltynm VARCHAR2(300),
    poster VARCHAR2(300),
    area VARCHAR2(90),
    genrenm VARCHAR2(30),
    openrun CHAR(1),
    prfstate VARCHAR2(30)
);

--대관 정보
create table reservHall(
	reservation_num	number primary key,
	mem_num	number not null references member (mem_num),
	reservation_form1 varchar2(200) not null,
	reservation_form2 varchar2(200),
	reservation_form3 varchar2(200),
	reservation_status number(1) default 0 not null,
	reservation_regdate	date default sysdate,
	reservation_modifydate date,
	reservation_name varchar2(30) not null,
	reservation_email varchar2(50) not null,
	reservation_phone varchar2(30) not null
);

create sequence reserv_seq;

--대관 결제
create table paymenthall(
	reservation_num number primary key,
	reservation_price number not null,
	payment_date date default sysdate not null,
	payment_name varchar2(100) not null,
	payment_phone varchar2(50) not null,
	payment_status number(1) default 0 not null,
);

