package com.coffeeshop.service;

import com.coffeeshop.domain.OrderVO;
import com.coffeeshop.domain.OrderedProductVO;

import java.util.List;

public interface OrderService {

    public void regist(OrderVO orderVO);
    public void setChoose(OrderedProductVO orderedPVO);
    public boolean removeChoose(int opno);
    public List<OrderedProductVO> getChooseList(int ono);
    public void setOrder(OrderVO orderVO, int amount, int total);
    public List<OrderVO> getWating();
    public boolean complete(String customer, String manager);
    public boolean cancle(int ono);

}
