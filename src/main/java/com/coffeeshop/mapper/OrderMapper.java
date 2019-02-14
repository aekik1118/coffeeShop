package com.coffeeshop.mapper;

import com.coffeeshop.domain.OrderVO;

import java.util.List;

public interface OrderMapper {

    public void insert(OrderVO vo);
    public int delete(int ono);
    public void insertAmount();
    public void insertPrice();
    public List<OrderVO> watingList(String customer);
    public List<OrderVO> completeList();
}
