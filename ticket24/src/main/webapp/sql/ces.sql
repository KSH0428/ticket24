--일대일 문의
create table question(
 question_num number not null,
 mem_num number not null,
 question_ip varchar2(40) not null,
 question_category number(1) not null, --1:상품,2:주문,3:배송,4:기타
 question_title varchar2(150) not null,
 question_lock number(1) not null, --1:공개,2:비밀
 question_passwd varchar2(12),
 question_photo varchar2(150),
 question_content clob not null,
 question_regdate date default sysdate not null,
 question_modifydate date,
 question_level number(1) not null, --1:질문,2:답변
 question_renum number, --관리자 답변 시 원글 번호를 저장하기 위함
 question_hit number(8) default 0 not null,
 constraint question_pk primary key (question_num),
 constraint question_fk foreign key (mem_num) references member(mem_num)
);

create sequence question_seq;

--자주 찾는 질문
create table faq(
 faq_num number not null,
 faq_title varchar2(300) not null,
 faq_content clob not null,
 faq_category number(1) not null, --1:티켓예매,2:취소/환불,3:기타)
 constraint faq_pk primary key (faq_num)
);

create sequence faq_seq;







