package com.coffeeshop.service;

import com.coffeeshop.config.RootConfig;
import com.coffeeshop.domain.OrderVO;
import com.coffeeshop.domain.StatisticsDTO;
import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.web.bind.annotation.RequestMapping;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {RootConfig.class})
@Log4j
public class StatisticsServiceTests {

    @Setter(onMethod_ = {@Autowired})
    private StatisticsService service;

    @Test
    public void getCompleteTests() {
        List<OrderVO> completeList = service.getComplete();

        completeList.forEach(OrderVO -> log.info(OrderVO));
    }

    @Test
    public void getStatisticsListTest() {
        List<StatisticsDTO> list = service.getStatisticsList("2019-03-01", 15);

        list.forEach(StatisticsDTO -> log.info(StatisticsDTO));

    }
}