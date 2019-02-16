package com.coffeeshop.mapper;

import com.coffeeshop.domain.Criteria;
import com.coffeeshop.domain.ProductVO;

import java.util.List;

public interface ProductMapper {
    public int register(ProductVO product);
    public int remove(String productid);
    public int modify(ProductVO product);
    public List<ProductVO> getList(Criteria cri);
    public int getTotal();

}
