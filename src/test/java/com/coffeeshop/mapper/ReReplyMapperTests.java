package com.coffeeshop.mapper;

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
public class ReReplyMapperTests {

    @Setter(onMethod_ = {@Autowired})
    private ReReplyMapper mapper;

    @Test
    public void initMapper(){
        log.info(mapper);
    }

    @Test
    public void crdTests(){
        ReReplyVO reReplyVO = new ReReplyVO();

        reReplyVO.setBno(14345L);
        reReplyVO.setParentRno(1L);
        reReplyVO.setReply("test Rereply");
        reReplyVO.setReplyer("testRereplyer");

        mapper.insert(reReplyVO);
        log.info(mapper.read(reReplyVO.getRno()));
        mapper.delete(reReplyVO.getRno());
    }

    @Test
    public void getList(){
        mapper.getList(1L).forEach( reReplyVO -> log.info(reReplyVO));
    }

}
