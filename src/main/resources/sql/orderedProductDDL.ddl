CREATE SEQUENCE seq_orderedProduct;

CREATE TABLE tbl_orderedProduct (
    opno number(10, 0),
    ono number(10, 0) NOT NULL,
    product VARCHAR2(100) NOT NULL,
    price number(10, 0) NOT NULL,
    count NUMBER(10, 0) NOT NULL,
    opdate DATE default sysdate()
);

alter table tbl_orderedProduct add constraint pk_orderedProduct primary key (opno);

alter table tbl_orderedProduct add CONSTRAINT fk_orderedProduct_order
foreign key (ono) references tbl_order (ono);