package com.coffeeshop.service;

import com.coffeeshop.domain.ReReplyVO;
import com.coffeeshop.mapper.ReReplyMapper;
import com.coffeeshop.mapper.ReplyMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Log4j
@Service
public class ReReplyServiceImpl implements ReReplyService {

    @Setter(onMethod_ = {@Autowired})
    private ReplyMapper replyMapper;

    @Setter(onMethod_ = {@Autowired})
    private ReReplyMapper mapper;

    @Transactional
    @Override
    public int register(ReReplyVO vo) {
        log.info("register rereply : " + vo);
        replyMapper.updateReReplyCnt(vo.getParentRno(), 1);
        return mapper.insert(vo);
    }

    @Override
    public ReReplyVO get(Long rno) {
        log.info("get rereply....." + rno);
        return mapper.read(rno);
    }

    @Transactional
    @Override
    public int remove(Long rno) {
        log.info("remove rereply....." + rno);
        ReReplyVO vo = mapper.read(rno);
        replyMapper.updateReReplyCnt(vo.getParentRno(), -1);
        return mapper.delete(rno);
    }

    @Override
    public List<ReReplyVO> getList(Long parentRno) {
        return mapper.getList(parentRno);
    }
}
