package com.coffeeshop.service;

import com.coffeeshop.config.RootConfig;
import com.coffeeshop.domain.ReReplyVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {RootConfig.class})
@Log4j
public class ReReplyServiceTests {

    @Setter(onMethod_ = {@Autowired})
    private ReReplyService service;

    @Test
    public void initTest(){
        log.info(service);
    }

    @Test
    public void crdTests(){
        ReReplyVO reReplyVO = new ReReplyVO();

        reReplyVO.setBno(14345L);
        reReplyVO.setParentRno(9L);
        reReplyVO.setReply("test Rereply");
        reReplyVO.setReplyer("testRereplyer");

        service.register(reReplyVO);
        log.info(service.get(reReplyVO.getRno()));
        service.remove(reReplyVO.getRno());
    }

    @Test
    public void getListTest(){
        service.getList(1L).forEach(reReplyVO -> log.info(reReplyVO));
    }
}
