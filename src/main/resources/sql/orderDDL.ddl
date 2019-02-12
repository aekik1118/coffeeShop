CREATE SEQUENCE seq_order;

CREATE TABLE tbl_order (
    ono number(10, 0) ,
    customer VARCHAR2(50) NOT NULL,
    product VARCHAR2(100) NOT NULL,
    amount NUMBER(10, 0) NOT NULL,
    price NUMBER(10, 0) DEFAULT 0,
    manager VARCHAR2(100) NOT NULL,
    odate DATE DEFAULT sysdate,
    sold CHAR(1) DEFAULT 0
);

alter table tbl_order add constraint pk_order primary key (ono);