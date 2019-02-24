package com.coffeeshop.controller;

import com.coffeeshop.domain.Criteria;
import com.coffeeshop.domain.PageDTO;
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
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@RequestMapping("/product/")
@Controller
@Log4j
@AllArgsConstructor
public class ProductController {

    @Setter(onMethod_ = {@Autowired})
    private ProductService service;

    @GetMapping("/list")
    public void getList(Criteria cri, Model model){
        log.info("product list");
        log.info("list : "+ cri);

        int Total = service.getTotal();

        model.addAttribute("list", service.getList(cri));
        model.addAttribute("pageMaker", new PageDTO(cri, Total));
    }

    @PostMapping(value = "/register", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
    public ResponseEntity<String> register(@RequestBody ProductVO product) {
        log.info("=========================");
        log.info("register : " + product);
        log.info("=========================");

        if(product.getAttach() != null) log.info(product.getAttach());

        int regCount = service.register(product);

        log.info("Product Register Count : " + regCount);
        return regCount == 1 ? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @GetMapping(value = "/{productid}", produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
    public ResponseEntity<ProductVO> get(@PathVariable("productid") String productid) {
        log.info("get : " + productid);
        return new ResponseEntity<>(service.get(productid), HttpStatus.OK);
    }

    @PutMapping(value="/{productid}", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
    public ResponseEntity<String> modify(@RequestBody ProductVO product, @PathVariable("productid") String productid) {

        log.info(productid + " modify : " + product);
        return service.modify(product) == 1 ? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @DeleteMapping(value="/{productid}", produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE })
    public ResponseEntity<String> remove(@PathVariable("productid") String productid) {

        log.info("remove : " + productid);
        return service.remove(productid) == 1 ? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }
}
