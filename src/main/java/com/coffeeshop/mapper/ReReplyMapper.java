package com.coffeeshop.mapper;

import com.coffeeshop.domain.ReReplyVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ReReplyMapper {

    public int insert(ReReplyVO vo);

    public ReReplyVO read(long rno);

    public int delete(long rno);

    public List<ReReplyVO> getList( @Param("parentRno") Long parentRno);

    //public int update(ReReplyVO vo);
}
