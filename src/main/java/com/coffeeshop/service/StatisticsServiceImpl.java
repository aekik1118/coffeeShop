package com.coffeeshop.service;

import com.coffeeshop.domain.OrderVO;
import com.coffeeshop.domain.StatisticsDTO;
import com.coffeeshop.mapper.OrderMapper;
import com.coffeeshop.mapper.OrderedProductMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Log4j
@Service
public class StatisticsServiceImpl implements StatisticsService {

    @Setter(onMethod_ = {@Autowired})
    private OrderMapper mapper;

    @Setter(onMethod_ = {@Autowired})
    private OrderedProductMapper orderedPMapper;

    @Override
    public List<OrderVO> getComplete(){
        log.info("getComplete.................:" + mapper.completeList());
        return mapper.completeList();
    }

    @Override
    public StatisticsDTO getStatistics() {
        StatisticsDTO statistics = new StatisticsDTO();
        statistics.setOrderCnt(mapper.getOnoConunt());
        statistics.setProductCnt(orderedPMapper.allProductCount());
        statistics.setTotalSales(mapper.getTotalSales());
        return statistics;
    }

    @Override
    public int getSingleProductCnt(String product) {
        return orderedPMapper.singleProductCount(product);
    }


}
