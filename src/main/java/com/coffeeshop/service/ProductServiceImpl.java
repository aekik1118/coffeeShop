package com.coffeeshop.service;

import com.coffeeshop.domain.Criteria;
import com.coffeeshop.domain.ProductVO;
import com.coffeeshop.mapper.ProductMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Log4j
@Service
public class ProductServiceImpl implements ProductService {

    @Setter(onMethod_ = {@Autowired})
    private ProductMapper mapper;

    @Override
    public int register(ProductVO product) {
        log.info("regist product : " + product);
        return mapper.register(product);
    }

    @Override
    public int modify(ProductVO product) {
        log.info(product.getProductId() + " modify to : " + product);
        return mapper.modify(product);
    }

    @Override
    public int remove(String productid) {
        log.info(productid + " remove");
        return mapper.remove(productid);
    }

    @Override
    public List<ProductVO> getList(Criteria cri) {
        log.info("Product list ....");
        return mapper.getList(cri);
    }

    @Override
    public int getTotal() {
        int totalResult = mapper.getTotal();

        log.info("getTotal : " + totalResult);
        return totalResult;
    }
}
