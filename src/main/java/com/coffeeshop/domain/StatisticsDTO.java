package com.coffeeshop.domain;

import lombok.Data;

@Data
public class StatisticsDTO {
    private int orderCnt;
    private int productCnt;
    private int totalSales;
}
