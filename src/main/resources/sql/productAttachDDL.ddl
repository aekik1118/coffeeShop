create table tbl_productAttach (
    uuid varchar2(100) not null,
    uploadPath varchar2(200) not null,
    fileName varchar2(100) not null,
    productid varchar2(100)
);

alter table tbl_productAttach add constraint pk_productAttach primary key (uuid);
alter table tbl_productAttach add constraint fk_product_attach foreign key (productid) references tbl_product(productid);