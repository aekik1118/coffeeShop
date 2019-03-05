package com.coffeeshop.service;

import com.coffeeshop.domain.BoardAttachVO;
import com.coffeeshop.domain.BoardVO;
import com.coffeeshop.domain.Criteria;

import java.util.List;


public interface BoardService {

	public void register(BoardVO board);
	public BoardVO get(Long bno);
	public boolean modify(BoardVO board, List<BoardAttachVO> addAttachVOList);
	public boolean remove(Long bno);
	//public List<BoardVO> getList();
	public List<BoardVO> getList(Criteria cri);
	public int getTotal(Criteria cri);
	public List<BoardAttachVO> getAttachList(Long bno);
	public BoardAttachVO getAttach(String uuid);
	public boolean removeFiles(List<BoardAttachVO> removeAttachList);
}
