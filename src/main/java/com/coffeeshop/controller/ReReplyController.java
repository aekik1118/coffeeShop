package com.coffeeshop.controller;


import com.coffeeshop.domain.ReReplyVO;
import com.coffeeshop.service.ReReplyService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RequestMapping("/rereplies/")
@RestController
@Log4j
@AllArgsConstructor
public class ReReplyController {

    private ReReplyService service;

    @PostMapping(value = "/new", consumes = "application/json", produces = { MediaType.TEXT_PLAIN_VALUE })
    public ResponseEntity<String> create(@RequestBody ReReplyVO vo) {

        log.info("ReReplyVO: " + vo);

        int insertCount = service.register(vo);

        log.info("ReReply INSERT COUNT: " + insertCount);

        return insertCount == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
                : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @GetMapping(value = "/list/{parentrno}", produces = { MediaType.APPLICATION_ATOM_XML_VALUE,
            MediaType.APPLICATION_JSON_UTF8_VALUE })
    public ResponseEntity<List<ReReplyVO>> getList(@PathVariable("parentrno") Long parentRno) {

        log.info("get Reply List parentrno: " + parentRno);
        return new ResponseEntity<>(service.getList(parentRno), HttpStatus.OK);
    }


    @GetMapping(value = "/{rno}", produces = { MediaType.APPLICATION_ATOM_XML_VALUE,
            MediaType.APPLICATION_JSON_UTF8_VALUE })
    public ResponseEntity<ReReplyVO> get(@PathVariable("rno") Long rno) {
        log.info("get: " + rno);
        return new ResponseEntity<>(service.get(rno), HttpStatus.OK);
    }

    @DeleteMapping(value = "/{rno}", produces = { MediaType.TEXT_PLAIN_VALUE })
    public ResponseEntity<String> remove(@RequestBody ReReplyVO vo, @PathVariable("rno") Long rno) {
        log.info("remove Rereply: " + rno);
        log.info("rereplyer: " + vo.getReplyer());

        return service.remove(rno) == 1 ? new ResponseEntity<String>("success", HttpStatus.OK)
                : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }

}
