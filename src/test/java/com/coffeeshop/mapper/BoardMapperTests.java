package com.coffeeshop.mapper;

import com.coffeeshop.config.RootConfig;
import com.coffeeshop.domain.BoardVO;
import com.coffeeshop.domain.Criteria;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import static org.junit.Assert.*;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {RootConfig.class})
@Log4j
public class BoardMapperTests {

    @Setter(onMethod_ = {@Autowired})
    private BoardMapper mapper;

    @Test
    public void mapperTest(){
        log.info(mapper);
    }

    @Test
    public void getListTests(){
        mapper.getList().forEach(boardVO -> log.info(boardVO));
    }

    @Test
    public void getListWithPagingTests(){
        mapper.getListWithPaging(new Criteria()).forEach(boardVO -> log.info(boardVO));
    }

    @Test
    public void crudTest(){

        BoardVO boardVO = new BoardVO();
        boardVO.setTitle("crudTest Title");
        boardVO.setContent("crudTest Content");
        boardVO.setWriter("crudTest Writer");

        mapper.insertSelectKey(boardVO);

        int count = mapper.getTotalCount(new Criteria());

        log.info(count);

        BoardVO readBoardVO = mapper.read(boardVO.getBno());

        log.info(readBoardVO);

        assertEquals(boardVO.getTitle(),readBoardVO.getTitle());
        assertEquals(boardVO.getContent(),readBoardVO.getContent());
        assertEquals(boardVO.getWriter(),readBoardVO.getWriter());

        boardVO.setTitle("crudTest update Title");
        mapper.update(boardVO);

        readBoardVO = mapper.read(boardVO.getBno());

        assertEquals(boardVO.getTitle(),readBoardVO.getTitle());
        assertEquals(boardVO.getContent(),readBoardVO.getContent());
        assertEquals(boardVO.getWriter(),readBoardVO.getWriter());

        mapper.delete(boardVO.getBno());

        assertEquals(count-1,mapper.getTotalCount(new Criteria()));

    }



}
