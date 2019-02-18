package com.coffeeshop.mapper;

import com.coffeeshop.domain.OrderedProductVO;

import java.util.List;

public interface OrderedProductMapper {

    public void insert(OrderedProductVO vo);
    public boolean delete(int opno);
    public List<OrderedProductVO> select(int ono);
    public void cancle(int ono);
}
