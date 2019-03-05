package com.coffeeshop.service;

import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import com.coffeeshop.domain.BoardAttachVO;
import com.coffeeshop.domain.BoardVO;
import com.coffeeshop.domain.Criteria;
import com.coffeeshop.mapper.BoardAttachMapper;
import com.coffeeshop.mapper.BoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class BoardServiceImpl implements BoardService {

	
	@Setter(onMethod_ = {@Autowired})
	private BoardMapper mapper;
	
	@Setter(onMethod_ = {@Autowired})
	private BoardAttachMapper attachMapper;
	
	@Transactional
	@Override
	public void register(BoardVO board) {
		log.info("register.." + board);
		mapper.insertSelectKey(board);
		
		if(board.getAttachList() == null || board.getAttachList().size() <= 0) {
			return ;
		}
		
		board.getAttachList().forEach(attach ->{
			attach.setBno(board.getBno());
			attachMapper.insert(attach);
		});
		
		
	}

	@Override
	public BoardVO get(Long bno) {
		log.info("get........." + bno);
		BoardVO boardVO = mapper.read(bno);
		boardVO.setAttachList(attachMapper.findByBno(boardVO.getBno()));

		if(boardVO.getAttachList() != null){
			boardVO.getAttachList().forEach(boardAttachVO -> {
				try{
					String encodeURI = URLEncoder.encode( boardAttachVO.getUploadPath() + "\\" + boardAttachVO.getUuid() + "_" + boardAttachVO.getFileName(),"UTF-8");
					boardAttachVO.setFileDownloadURI(encodeURI);
				}catch (Exception e){
					e.printStackTrace();
				}
			});
		}

		return boardVO;
	}

	@Transactional
	@Override
	public boolean modify(BoardVO board, List<BoardAttachVO> addAttachVOList) {
		log.info("modify.." + board);

	/*	if(board.getAttachList() != null && board.getAttachList().size() > 0){
			deleteFiles(attachMapper.findByBno(board.getBno()));
			attachMapper.deleteAll(board.getBno());

			board.getAttachList().forEach(attach ->{
				attach.setBno(board.getBno());
				attachMapper.insert(attach);
			});
		}*/

	    log.info(addAttachVOList);

	    if(addAttachVOList != null){
            addAttachVOList.forEach(boardAttachVO -> {
                boardAttachVO.setBno(board.getBno());
                attachMapper.insert(boardAttachVO);
            });
        }

		boolean modifyResult = mapper.update(board) == 1;
		return modifyResult;
	}

	@Transactional
	@Override
	public boolean remove(Long bno) {
		log.info("remove.........." + bno);
		deleteFiles(attachMapper.findByBno(bno));
		attachMapper.deleteAll(bno);
		return mapper.delete(bno)==1;
	}

	@Override
	public List<BoardVO> getList(Criteria cri) {
		log.info("getList With criteria........");
		return mapper.getListWithPaging(cri);
		
	}

	@Override
	public int getTotal(Criteria cri) {
		log.info("get total count");
		return mapper.getTotalCount(cri);
	}
	
	@Override
	public List<BoardAttachVO> getAttachList(Long bno){
		log.info("get Attach list by bno"+bno);
		return attachMapper.findByBno(bno);
	}

	@Override
	public boolean removeFiles(List<BoardAttachVO> removeAttachList) {

		removeAttachList.forEach(boardAttachVO -> {
			attachMapper.delete(boardAttachVO.getUuid());
		});
		deleteFiles(removeAttachList);

		return false;
	}

	private void deleteFiles(List<BoardAttachVO> attachList) {

		if(attachList == null || attachList.size() == 0) {
			return;
		}
		log.info("delete attach files.............");
		log.info(attachList);

		attachList.forEach(attach ->{
			try {
				Path file = Paths.get(attach.getUploadPath()+"\\"+attach.getUuid()+"_"+attach.getFileName());
				Files.deleteIfExists(file);
			}catch(Exception e) {
				log.error("delete file error"+ e.getMessage());
			}
		});
	}


	@Override
	public BoardAttachVO getAttach(String uuid) {
		log.info("get Attach.." + uuid);
		return attachMapper.select(uuid);
	}
}
