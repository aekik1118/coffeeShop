package com.coffeeshop.controller;

import com.coffeeshop.domain.StatisticsDTO;
import com.coffeeshop.service.StatisticsService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@Log4j
@RequestMapping("/statistics/*")
@AllArgsConstructor
public class StatisticsController {

    private StatisticsService service;

    @GetMapping("/chart")
    public @ResponseBody List<StatisticsDTO> chart(){
        log.info("chart(get)...........");
        return service.getStatisticsList("2019-01-25");
    }

    @PostMapping("/chart")
    public @ResponseBody List<StatisticsDTO> chart(@RequestParam("startDate") String startDate){

        log.info("chart(post)..........");
        return service.getStatisticsList(startDate);
    }
}
