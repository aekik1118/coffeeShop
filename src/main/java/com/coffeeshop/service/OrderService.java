package com.coffeeshop.service;

import com.coffeeshop.domain.OrderVO;
import com.coffeeshop.domain.OrderedProductVO;

import java.util.List;

public interface OrderService {

    public void choose(OrderVO orderVO, OrderedProductVO orderedPVO);
    public List<OrderVO> getWating();
    public boolean complete(String customer);
    public boolean cancle(String customer);

}
