package com.coffeeshop.service;

import com.coffeeshop.domain.Criteria;
import com.coffeeshop.domain.ProductVO;

import java.util.List;

public interface ProductService {
    public int register(ProductVO product);
    public int modify(ProductVO product);
    public int remove(String productid);
    public List<ProductVO> getList(Criteria cri);
    public int getTotal();
}
