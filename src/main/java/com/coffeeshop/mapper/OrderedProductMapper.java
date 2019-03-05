package com.coffeeshop.mapper;

import com.coffeeshop.domain.OrderedProductVO;

import java.util.Date;
import java.util.List;

public interface OrderedProductMapper {

    public void insert(OrderedProductVO vo);
    public boolean delete(int opno);
    public List<OrderedProductVO> select(int ono);
    public void cancle(int ono);
    public int allProductCount(Date xDate);
    public int singleProductCount(String product, Date xDate);

}
