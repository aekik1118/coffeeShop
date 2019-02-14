package com.coffeeshop.mapper;

import com.coffeeshop.domain.OrderedProductVO;

import java.util.List;

public interface OrderedProductMapper {

    public void insert(OrderedProductVO vo);
    public void delete(int opno);
    public List<OrderedProductVO> select(int ono);
}
