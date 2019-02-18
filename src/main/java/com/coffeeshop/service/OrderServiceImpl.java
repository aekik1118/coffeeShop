package com.coffeeshop.service;

import com.coffeeshop.domain.OrderVO;
import com.coffeeshop.domain.OrderedProductVO;
import com.coffeeshop.mapper.OrderMapper;
import com.coffeeshop.mapper.OrderedProductMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Log4j
@Service
public class OrderServiceImpl implements OrderService{


    @Setter(onMethod_ = {@Autowired})
    private OrderMapper mapper;

    @Setter(onMethod_ = {@Autowired})
    private OrderedProductMapper orderedPMapper;

    @Override
    public void regist(OrderVO orderVO){
        log.info("regist.............:" + orderVO);
        mapper.insert(orderVO);
    }
    @Override
    public void setChoose(OrderedProductVO orderedPVO){
        log.info("setChoose............:" + orderedPVO);
        orderedPMapper.insert(orderedPVO);
    }

    @Override
    public boolean removeChoose(int opno){
        log.info("removeChoose............:" + opno);
        return orderedPMapper.delete(opno);
    }

    @Override
    public List<OrderedProductVO> getChooseList(int ono){
        log.info("getChooseList.............:" + orderedPMapper.select(ono));
        return orderedPMapper.select(ono);
    }

    @Override
    public void setOrder(OrderVO orderVO, int amount, int total){

        mapper.insertAmount(amount);
        mapper.insertTotal(total);
        log.info("setOrder................" + orderVO);
    }
//    @Override
//    public void choose(OrderVO orderVO, OrderedProductVO orderedPVO) {
//        log.info("choose.......... :" + orderVO +"  " + orderedPVO);
//        mapper.insert(orderVO);
//        orderedPMapper.insert(orderedPVO);

//        int amount = 0;
//        int price = 0;
//        for(OrderedProductVO vo : orderedPMapper.select(orderVO.getOno())) {
//            amount += vo.getCount();
//            price += vo.getCount() * vo.getPrice();
//        }

//        mapper.insertAmount(amount);
//        mapper.insertPrice(price);
//    }

    @Override
    public List<OrderVO> getWating() {

        log.info("Wating List.......... :" + mapper.watingList());
        return mapper.watingList();
    }

    @Override
    public boolean complete(String customer, String manager) {

        return mapper.setSold(customer, manager);
    }

    @Override
    public boolean cancle(int ono) {

        log.info("cancle...............:" + ono);
        orderedPMapper.delete(ono);
        return mapper.delete(ono);
    }
}
