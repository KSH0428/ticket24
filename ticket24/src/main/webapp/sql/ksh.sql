--커뮤니티 게시판
create table comm(
 comm_num number not null,
 mem_num number not null,
 comm_title varchar2(150) not null,
 comm_content clob not null,
 comm_hit number(9) default 0 not null,
 comm_regdate date default sysdate not null,
 comm_modifydate date,
 comm_filename varchar2(200),
 comm_category number(1) not null,
 comm_ip varchar2(40),
 constraint comm_pk primary key(comm_num),
 constraint comm_fk foreign key(mem_num) references member(mem_num)
);
create sequence comm_seq;

--커뮤니티 좋아요
create table comm_fav(
 comm_num number not null,
 mem_num number not null, 
 constraint comm_fav_fk1 foreign key (comm_num) references comm(comm_num),
 constraint comm_fav_fk2 foreign key (mem_num) references member(mem_num)
);

--커뮤니티 댓글
create table comm_reply(
 comm_renum number not null,
 mem_num number not null,
 comm_num number not null,
 comm_recontent varchar2(900) not null,
 comm_redate date default sysdate not null,
 comm_remodifydate date,
 comm_reip varchar2(40) not null,
 constraint comm_reply_pk primary key(comm_renum),
 constraint comm_reply_fk1 foreign key(mem_num) references member(mem_num),
 constraint comm_reply_fk2 foreign key(comm_num) references comm(comm_num)
);
create sequence comm_reply_seq;

--티켓 양도 게시판
create table ticket(
 ticket_num number not null,
 mem_num number not null,
 ticket_category number(1) not null,
 ticket_name varchar2(150) not null,
 ticket_date varchar2(50) not null,
 ticket_quantity number(3) not null,
 ticket_price number(10) not null,
 ticket_place varchar2(50) not null,
 ticket_seat varchar2(50) not null,
 ticket_special1 varchar2(300),
 ticket_special2 varchar2(300),
 ticket_hit number(9) default 0 not null,
 ticket_regdate date default sysdate not null,
 ticket_modifydate date,
 ticket_content clob not null,
 ticket_filename1 varchar2(200),
 ticket_filename2 varchar2(200),
 ticket_filename3 varchar2(200),
 ticket_filename4 varchar2(200),
 ticket_account varchar2(200) not null,
 ticket_status number(1) not null,
 constraint ticket_pk primary key(ticket_num),
 constraint ticket_fk foreign key(mem_num) references member(mem_num)
);
create sequence ticket_seq;

--티켓 찜
create table ticket_zzim(
 ticket_num number not null,
 mem_num number not null, 
 constraint ticket_zzim_fk1 foreign key (ticket_num) references ticket(ticket_num),
 constraint ticket_zzim_fk2 foreign key (mem_num) references member(mem_num)
);

--티켓 결제
create table ticket_pay(
 ticket_pay_num number not null,
 ticket_num number not null,
 ticket_pay_name varchar2(30) not null,
 ticket_pay_zipcode varchar2(5) not null,
 ticket_pay_address1 varchar2(50) not null,
 ticket_pay_address2 varchar2(50) not null,
 ticket_pay_phone varchar2(15) not null,
 mem_num number not null,
 constraint ticket_pay_pk primary key(ticket_pay_num),
 constraint mem_num_fk foreign key (mem_num) references member(mem_num)
 
);
create sequence ticket_pay_seq;