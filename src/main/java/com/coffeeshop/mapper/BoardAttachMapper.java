package com.coffeeshop.mapper;

import com.coffeeshop.domain.BoardAttachVO;

import java.util.List;


public interface BoardAttachMapper {
	
	public void insert(BoardAttachVO vo);
	
	public void delete(String uuid);
	
	public List<BoardAttachVO> findByBno(Long bno);
	
	public void deleteAll(Long bno);

	public BoardAttachVO select(String uuid);

}
