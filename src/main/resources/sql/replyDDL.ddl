CREATE TABLE tbl_reply(
  rno number(10,0),
  bno number(10,0) not null ,
  reply varchar2(1000) not null,
  replyer varchar2(50) not null,
  replyDate date default sysdate,
  updateDate date default sysdate,
  replycount number(10,0) default 0
);

create sequence seq_reply;

alter table tbl_reply add constraint pk_reply primary key (rno);

alter table tbl_reply add constraint fk_reply_board
foreign key (bno) references TBL_BOARD (bno) on delete cascade;

/*create index*/

create index idx_reply on tbl_reply (bno desc, rno asc);


/*rereply*/

CREATE TABLE tbl_reReply(
                        rno number(10,0),
                        bno number(10,0) not null,
                        parentRno number(10,0) not null,
                        reply varchar2(1000) not null,
                        replyer varchar2(50) not null,
                        replyDate date default sysdate,
                        updateDate date default sysdate
);

create sequence seq_reReply;

alter table tbl_reReply add constraint pk_reReply primary key (rno);

alter table tbl_reReply add constraint fk_reReply_reply
  foreign key (parentRno) references tbl_reply (rno) on delete cascade;

alter table tbl_reReply add constraint fk_reReply_board
  foreign key (bno) references tbl_board (bno) on delete cascade;