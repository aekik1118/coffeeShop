package com.coffeeshop.mapper;

import com.coffeeshop.domain.BoardVO;
import com.coffeeshop.domain.Criteria;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface BoardMapper {

    public List<BoardVO> getListWithPaging(Criteria cri);
    public List<BoardVO> getList();
    public void insert(BoardVO board);
    public void insertSelectKey(BoardVO board);
    public BoardVO read(Long bno);
    public int delete(Long bno);
    public int update(BoardVO board);
    public int getTotalCount(Criteria cri);
    public void updateReplyCnt(@Param("bno") Long bno, @Param("amount") int amount);
}
