package com.coffeeshop.service;

import com.coffeeshop.domain.Criteria;
import com.coffeeshop.domain.ProductVO;
import com.coffeeshop.mapper.ProductAttachMapper;
import com.coffeeshop.mapper.ProductMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Log4j
@Service
public class ProductServiceImpl implements ProductService {

    @Setter(onMethod_ = {@Autowired})
    private ProductMapper mapper;

    @Setter(onMethod_ = {@Autowired})
    private ProductAttachMapper attachMapper;

    //@Transactional
    @Override
    public int register(ProductVO product) {
        log.info("regist product : " + product);
        int regResult = mapper.register(product);
        if(product.getAttach() != null) {
            log.info("regist product attach : " + product.getAttach());
            attachMapper.insert(product.getAttach());
        }

        return regResult;
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

    @Override
    public ProductVO get(String productid) {
        log.info("get : " + productid);
        return mapper.get(productid);
    }
}
