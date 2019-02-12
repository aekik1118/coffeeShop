
/*create board table*/
create sequence seq_board;

CREATE TABLE tbl_board(
  bno number(10,0),
  title varchar2(200) not null ,
  content varchar2(2000) not null ,
  writer varchar2(50) not null ,
  regdate date default sysdate,
  updatedate date default sysdate,
  replycnt number default 0
);

alter table tbl_board add constraint pk_board
primary key (bno);

