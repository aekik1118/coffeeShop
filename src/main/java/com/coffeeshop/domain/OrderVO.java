package com.coffeeshop.domain;

import lombok.Data;

import java.util.Date;

@Data
public class OrderVO {
    private int ono;
    private String customer;
    private int amount;
    private int price;
    private String manager;
    private Date odate;
    private boolean sold;

    private List<OrderedProductVO> productList;
}
