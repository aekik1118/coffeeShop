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
    public void chart() {

    }

    @GetMapping("/doA")
    public void doA() {
        log.info("doA");
    }

    @PostMapping("/chart")
    public void chart(@RequestParam("startDate") String startDate, @RequestParam("term") int term, Model model){

        log.info("chart(post)..........");
        model.addAttribute("startDate",startDate);
        model.addAttribute("list", service.getStatisticsList(startDate, term));
        log.info(startDate);
        log.info(model.toString());
    }
}
