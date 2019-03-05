package com.coffeeshop.domain;

import lombok.Data;

import java.text.SimpleDateFormat;
import java.util.Date;

@Data
public class StatisticsDTO {
    private int orderCnt;
    private int totalSales;
    private String startDate;

    public void setStartDate(Date xDate){
        SimpleDateFormat transFormat = new SimpleDateFormat("yyyy,MM,dd");
        startDate = transFormat.format(xDate);
    }
}
