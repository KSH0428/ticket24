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

--md찜
create table md_zzim(
  mem_num number not null,
  md_num number not null,
  constraint zzim_member_fk1 foreign key (mem_num) 
                                   references member (mem_num),
  constraint zzim_md_fk2 foreign key (md_num)
                                   references md (md_num)
);

--md 리뷰게시판
create table md_review(
 md_review_num number not null,
 md_review_type number not null,
 md_title varchar2(90) not null,
 content_content clob not null,
 md_regdate date default sysdate not null,
 md_mdate date,
 md_filename varchar2(200),
 md_ip varchar2(40) not null,
 mem_num number not null,
 constraint md_review_pk primary key (md_review_num),
 constraint md_member_fk foreign key (mem_num) references member (mem_num)
);

create sequence md_review_seq;

--md 리뷰게시판 좋아요
create table md_review_fav(
  md_review_num number not null,
  mem_num number not null,
  constraint fav_mdreview_fk1 foreign key (md_review_num) 
                                   references md_review (md_review_num),
  constraint fav_mdmember_fk2 foreign key (mem_num)
                                   references member (mem_num)
);


--장바구니
create table md_cart(
	md_cart_num number not null,
	order_quantity number(5) not null,
	cart_regdate date default sysdate not null,
	md_num number not null,
	mem_num number not null,
	constraint md_cart_pk primary key (md_cart_num),
 	constraint md_fk1 foreign key (md_num) references md (md_num),
	constraint md_member_fk2 foreign key (mem_num) references member (mem_num)
);

create sequence md_cart_seq;

--주문
create table md_order(
 md_order_num number not null,
 md_item_name varchar2(600) not null, --대표 상품명
 md_order_total number(9) not null,
 md_payment number(1) not null, --결제 방식
 md_order_status number(1) default 1 not null, -- 배송 상태
 md_receive_name varchar2(30) not null,
 md_receive_post varchar2(5) not null,
 md_receive_address1 varchar2(90) not null,
 md_receive_address2 varchar2(90) not null,
 md_receive_phone varchar2(15) not null,
 md_refund_bank varchar2(15) not null,
 md_refund_bnumber number not null, --환불계좌번호
 md_notice varchar2(4000),
 md_order_regdate date default sysdate not null,
 md_order_mdate date,
 mem_num number not null,
 constraint md_order_pk primary key (md_order_num),
 constraint md_order_fk1 foreign key (mem_num) references member (mem_num)
);

create sequence md_order_seq;

create table md_order_detail(
 md_detail_num number not null,
 md_num number not null,
 md_item_name varchar2(30) not null,
 md_item_price number(8) not null,
 md_item_total number(8) not null,
 order_quantity number(7) not null,
 md_order_num number not null,
 constraint md_order_detail_pk primary key (md_detail_num),
 constraint md_order_detail_fk1 foreign key (md_order_num) references md_order (md_order_num)
);

create sequence md_order_detail_seq;



