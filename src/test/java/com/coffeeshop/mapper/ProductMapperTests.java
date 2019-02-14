package com.coffeeshop.mapper;

import com.coffeeshop.config.RootConfig;
import com.coffeeshop.domain.Criteria;
import com.coffeeshop.domain.ProductVO;
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
public class ProductMapperTests {

    @Setter(onMethod_ = {@Autowired})
    private ProductMapper mapper;
    /*
    @Test
    public void mapperTest() {
        log.info(mapper);
    }

    @Test
    public void registerTest() {
        ProductVO product = new ProductVO();
        product.setProductId("test case");
        product.setPrice(3000);
        product.setIce_possible(true);
        product.setExplain("Americano explain");

        mapper.register(product);
        log.info(product);
    }

    @Test
    public void modifyTest() {
        ProductVO product = new ProductVO();
        product.setProductId("test case");
        product.setPrice(5000);
        product.setIce_possible(false);
        product.setExplain("modify test");

        if(mapper.modify(product) == 1)  log.info("modify success ProductVO : " + product);
        else log.info("modify fail");
    }


    @Test
    public void removeTest() {
        String str = "test case";

        if(mapper.remove(str) == 1) log.info(str + " remove success");
        else log.info(str + " remove fail");
    }
    */
    @Test
    public void getListTest() {
        Criteria cri = new Criteria();
        cri.setPageNum(2);
        cri.setAmount(9);

        List<ProductVO> list = mapper.getList(cri);
        list.forEach(product -> log.info(product.getProductId()));
    }

}
