package com.coffeeshop.mapper;

import com.coffeeshop.domain.OrderVO;

import java.util.Date;
import java.util.List;

public interface OrderMapper {

    public void insert(OrderVO vo);
    public boolean delete(int ono);
    public void insertAmount(int ono, int amount);
    public void insertTotal(int ono, int total);
    public List<OrderVO> watingList();
    public boolean setSold(String customer, String manager);
    public List<OrderVO> completeList();
    public int getOnoCount (Date xdate);
    public int getTotalSales(Date xdate);
    public Date getDate(Date xdate);
}
