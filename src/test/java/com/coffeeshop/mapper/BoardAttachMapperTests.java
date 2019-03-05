package com.coffeeshop.mapper;

import com.coffeeshop.config.RootConfig;
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
public class BoardAttachMapperTests {

    @Setter(onMethod_ = {@Autowired})
    private BoardAttachMapper mapper;

    @Test
    public void getAttachTest(){
        log.info(mapper.select("0c9ff4b8-41c1-4663-8f59-418fb5236bff"));
    }

}
