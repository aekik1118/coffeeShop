package com.coffeeshop.mapper;

import com.coffeeshop.config.RootConfig;
import com.coffeeshop.domain.ProductVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {RootConfig.class})
@Log4j
public class ProductMapperTests {

    @Setter(onMethod_ = {@Autowired})
    private ProductMapper mapper;

    @Test
    public void mapperTest() {
        log.info(mapper);
    }
    @Test
    public void registerTest() {
        ProductVO product = new ProductVO();
        product.setProductId("Americano");
        product.setPrice(3000);
        product.setIce_possible(true);
        product.setExplain("Americano explain");

        log.info("Product : " + product);
        mapper.register(product);
    }
}
