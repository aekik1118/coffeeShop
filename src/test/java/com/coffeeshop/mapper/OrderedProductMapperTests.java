package com.coffeeshop.mapper;

import com.coffeeshop.config.RootConfig;
import com.coffeeshop.domain.StatisticsDTO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {RootConfig.class})
@Log4j
public class OrderedProductMapperTests {

    @Setter(onMethod_ = {@Autowired})
    private OrderedProductMapper mapper;

    @Test
    public void initTest(){
        log.info(mapper);
    }

    @Test
    public void allProductCountTest(){

        String testDate = "2019-02-20";
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        try {
            Date xDate = format.parse(testDate);
            System.out.println(xDate);
            int ret = mapper.allProductCount(xDate);
            System.out.println(ret);
        }catch (Exception e){
            e.printStackTrace();
        }

    }
}
