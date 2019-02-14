package com.coffeeshop.domain;

import lombok.Data;

@Data
public class OrderedProductVO {
    private int ono;
    private int opno;
    private String product;
    private int count;
}