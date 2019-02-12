package com.coffeeshop.domain;

import lombok.Data;

@Data
public class ProductVO {

    private String productId;
    private int price;
    private Boolean ice_possible;
    private String explain;
}
