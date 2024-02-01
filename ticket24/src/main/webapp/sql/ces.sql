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

--이벤트
create table event(
 event_num number not null,
 event_title varchar2(150) not null,
 event_start varchar2(10) not null,
 event_end varchar2(10) not null,
 event_content clob,
 event_hit number(9) default 0 not null,
 event_photo1 varchar2(150),
 event_photo2 varchar2(150),
 event_point number not null,
 event_regdate date default sysdate not null,
 event_modifydate date,
 constraint event_pk primary key (event_num)
);

create sequence event_seq;

--이벤트 댓글
create table event_reply(
 event_renum number not null,
 event_recontent varchar2(900),
 event_regdate date default sysdate not null,
 event_modifydate date,
 event_reip varchar2(40) not null,
 event_num number not null,
 mem_num number not null,
 constraint event_reply_pk primary key (event_renum),
 constraint event_reply_fk1 foreign key (event_num) references event(event_num),
 constraint event_reply_fk2 foreign key (mem_num) references member(mem_num)
);

create sequence event_reply_seq;

--채팅방
create table chatroom(
 chatroom_num number not null,
 mem_num number not null,
 constraint chatroom_pk primary key (chatroom_num),
 constraint chatroom_fk foreign key (mem_num) references member(mem_num)
);

create sequence chatroom_seq;

--채팅 메시지
create table chatmessage(
 chat_num number not null,
 chatroom_num number not null,
 mem_num number not null,
 message varchar2(4000) not null,
 send_date date default sysdate not null,
 read_check number default 1 not null,
 constraint chatmessage_pk primary key (chat_num),
 constraint chatmessage_fk1 foreign key (chatroom_num) references chatroom(chatroom_num),
 constraint chatmessage_fk2 foreign key (mem_num) references member(mem_num)
);

create sequence chatmessage_seq;
























