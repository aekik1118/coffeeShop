package com.coffeeshop.service;

import com.coffeeshop.domain.OrderVO;
import com.coffeeshop.domain.StatisticsDTO;

import java.util.Date;
import java.util.List;

public interface StatisticsService {

    public List<OrderVO> getComplete();
    public List<StatisticsDTO> getStatisticsList(String startDate);
    public int getSingleProductCnt(String prduct, String xDate);
}
