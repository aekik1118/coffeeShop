package com.coffeeshop.service;

import com.coffeeshop.domain.OrderVO;
import com.coffeeshop.domain.StatisticsDTO;
import com.coffeeshop.mapper.OrderMapper;
import com.coffeeshop.mapper.OrderedProductMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
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
    public List<StatisticsDTO> getStatisticsList(String startDate) {

        StatisticsDTO statistics = new StatisticsDTO();
        List<StatisticsDTO> statisticsList = new ArrayList<>();
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");

        try {
            Date xDate = format.parse(startDate);

            Calendar cal = Calendar.getInstance();
            cal.setTime(xDate);
            for(int i = 0; i < 15; i++ ) {
                cal.add(Calendar.DATE, 1);
                statistics.setOrderCnt(mapper.getOnoCount(cal.getTime()));
                statistics.setProductCnt(orderedPMapper.allProductCount(cal.getTime()));
                statistics.setTotalSales(mapper.getTotalSales(cal.getTime()));
                statisticsList.add(statistics);
            }

        }catch (Exception e){
            e.printStackTrace();
        }

        return statisticsList;
    }

    @Override
    public int getSingleProductCnt(String product, String xDate) {

        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        Date date = new Date();

        try {

            date = format.parse(xDate);

        }catch (Exception e){
            e.printStackTrace();
        }

        return orderedPMapper.singleProductCount(product, date);
    }


}
