package com.coffeeshop.controller;

import com.coffeeshop.domain.OrderVO;
import com.coffeeshop.domain.OrderedProductVO;
import com.coffeeshop.service.OrderService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@Log4j
@RequestMapping("/order/*")
@AllArgsConstructor
public class OrderController {
    private OrderService service;
//  private ProductService pService;

    @GetMapping("/list")
    public void list(){

    }

    @PostMapping("/list")
    public void list(OrderVO orderVO, OrderedProductVO orderedPVO, Model model){
        log.info("list");
//      model.addAttribute("productList", pService.getList());

 //       model.addAttribute("chooseList", );
    }

//    @PostMapping("/choose")
//    public String choose(OrderVO orderVO, RedirectAttributes rttr){
//        log.info("choose");
 //   }
}

