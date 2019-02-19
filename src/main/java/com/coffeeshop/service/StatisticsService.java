package com.coffeeshop.service;

import com.coffeeshop.domain.OrderVO;
import com.coffeeshop.domain.StatisticsDTO;

import java.util.List;

public interface StatisticsService {

    public List<OrderVO> getComplete();
    public StatisticsDTO getStatistics();
    public int getSingleProductCnt(String prduct);
}
