package com.coffeeshop.controller;

import com.coffeeshop.domain.StatisticsDTO;
import com.coffeeshop.service.StatisticsService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@Log4j
@RequestMapping("/statistics/*")
@AllArgsConstructor
public class StatisticsController {

    private StatisticsService service;

    @GetMapping("/chart")
    public void chart(){
        log.info("chart(get)...........");
    }

    @PostMapping("/chart")
    public List<StatisticsDTO> chart(@RequestParam("startDate") String startDate){

        log.info("chart(post)..........");
        return service.getStatisticsList(startDate);
    }
}
