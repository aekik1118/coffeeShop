create table tbl_product (
    productid varchar2(100) not null primary key,
    price number(10,0) not null,
    ice_possible char(1) default '0',
    explain varchar2(1000)
);

alter table tbl_product add hot char(1) default '0';
alter table tbl_product rename COLUMN ice_possible to ice;
alter table tbl_product add imgPath varchar2(200) default 'null';