package com.coffeeshop.mapper;

import com.coffeeshop.domain.OrderVO;

import java.util.List;

public interface OrderMapper {

    public void insert(OrderVO vo);
    public boolean delete(int ono);
    public void insertAmount(int amount);
    public void insertTotal(int total);
    public List<OrderVO> watingList();
    public boolean setSold(String customer, String manager);
    public List<OrderVO> completeList();
}
