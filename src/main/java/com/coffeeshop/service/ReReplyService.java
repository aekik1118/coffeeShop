package com.coffeeshop.service;

import com.coffeeshop.domain.ReReplyVO;

import java.util.List;

public interface ReReplyService {

    public int register(ReReplyVO vo);

    public ReReplyVO get(Long rno);

    public int remove(Long rno);

    public List<ReReplyVO> getList(Long parentRno);
}
