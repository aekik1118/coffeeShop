package com.coffeeshop.domain;

import lombok.Data;

@Data
public class ProductVO {

    private String productId;
    private int price;
    private Boolean ice;
    private Boolean hot;
    private String explain;
    private String imgPath;

    private  ProductAttachVO attach;
}
