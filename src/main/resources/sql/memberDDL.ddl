create table tbl_member (
    userid varchar2(50) not null primary key,
    userpw varchar2(100) not null,
    username varchar2(100) not null,
    regdate date default sysdate,
    enabled char(1) default '1'
);