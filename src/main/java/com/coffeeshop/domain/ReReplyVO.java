package com.coffeeshop.domain;

import lombok.Data;

import java.util.Date;

@Data
public class ReReplyVO {
    private Long rno;
    private Long bno;
    private Long parentRno;

    private String reply;
    private String replyer;

    private Date replyDate;
    private Date updateDate;
}
