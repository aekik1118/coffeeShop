
/*create board table*/
create sequence seq_board;

CREATE TABLE tbl_board(
  bno number(10,0),
  title varchar2(200) not null ,
  content varchar2(2000) not null ,
  writer varchar2(50) not null ,
  regdate date default sysdate,
  updatedate date default sysdate,
  replycnt number default 0,
  attachcnt number default 0
);

alter table tbl_board add constraint pk_board
primary key (bno);

CREATE TABLE tbl_board_attach(
  uuid varchar2(100) not null,
  uploadPath varchar2(200) not null ,
  fileName varchar2(100) not null ,
  filetype char(1) default 'I',

  bno number(10,0)
);

alter table tbl_board_attach add constraint pk_attach primary key (uuid);

alter table tbl_board_attach add constraint fk_board_attach foreign key (bno)
references tbl_board(bno);

