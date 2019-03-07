package com.coffeeshop.service;

import com.coffeeshop.domain.Criteria;
import com.coffeeshop.domain.ProductAttachVO;
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

    @Transactional
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

    @Transactional
    @Override
    public int modify(ProductVO product) {
        log.info(product.getProductId() + " modify to : " + product);
        if(attachMapper.getAttach(product.getProductId()) != null  && product.getImgPath() == "") {
            product.setAttach(null);
            attachMapper.delete(product.getProductId());
        }

        int modResult = mapper.modify(product);

        if(product.getAttach() != null){
            log.info("update product attach : " + product.getAttach());
            if(attachMapper.getAttach(product.getProductId()) == null) attachMapper.insert(product.getAttach());
            else attachMapper.update(product.getAttach());
        }

        return modResult;
    }

    @Transactional
    @Override
    public int remove(String productid) {
        attachMapper.delete(productid);
        log.info(productid + " attach remove");

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

    @Override
    public ProductAttachVO getAttach(String productid) {
        log.info("service getAttach : " + productid);
        return attachMapper.getAttach(productid);
    }
}
