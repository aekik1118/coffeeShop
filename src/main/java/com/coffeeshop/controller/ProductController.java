package com.coffeeshop.controller;

import com.coffeeshop.domain.ProductVO;
import com.coffeeshop.service.ProductService;
import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@RequestMapping("/product/")
@Controller
@Log4j
@AllArgsConstructor
public class ProductController {

    @Setter(onMethod_ = {@Autowired})
    private ProductService service;

    @GetMapping("/list")
    public void getList(){
        log.info("product list");
    }

    @PostMapping(value = "/register", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
    public ResponseEntity<String> register(@RequestBody ProductVO product) {
        log.info("=========================");
        log.info("register : " + product);
        log.info("=========================");

        int regCount = service.register(product);

        log.info("Product Register Count : " + regCount);
        return regCount == 1 ? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }
}
