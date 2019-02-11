package com.coffeeshop.mapper;

import java.util.List;

import com.coffeeshop.domain.Criteria;
import com.coffeeshop.domain.ReplyVO;
import org.apache.ibatis.annotations.Param;


public interface ReplyMapper {

	public int insert(ReplyVO vo);
	
	public ReplyVO read(long rno);
	
	public int delete(long rno);
	
	public int update(ReplyVO vo);
	
	public List<ReplyVO> getListWithPaging(
            @Param("cri") Criteria cri,
            @Param("bno") Long bno);
	
	public int getCountByBno(Long bno);
}
