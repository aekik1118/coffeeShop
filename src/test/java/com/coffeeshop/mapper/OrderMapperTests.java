package com.coffeeshop.mapper;

import com.coffeeshop.config.RootConfig;
import com.coffeeshop.domain.OrderVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {RootConfig.class})
@Log4j
public class OrderMapperTests {

    @Setter(onMethod_ = {@Autowired})
    private OrderMapper mapper;

    @Test
    public void mapperTest(){
        log.info(mapper);
    }

    @Test
    public void allTest() {
        List<OrderVO> orderVOList = mapper.watingList();

        for(OrderVO orderVO : orderVOList) {
            log.info(orderVO.getOno() + ":" + orderVO.getCustomer());
        }

        mapper.insert(orderVOList.get(1));

        for(OrderVO orderVO : mapper.watingList()) {
            log.info(orderVO.getOno() + ":" + orderVO.getCustomer());
        }

        List<OrderVO> orderVOList2 = mapper.watingList();

        mapper.delete(orderVOList2.get(orderVOList2.size() - 1).getOno());

        for(OrderVO orderVO : mapper.watingList()) {
            log.info(orderVO.getOno() + ":" + orderVO.getCustomer());
        }
    }


}
