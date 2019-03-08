package com.coffeeshop.domain;

import lombok.Data;

@Data
public class ProductAttachVO {
    private String uuid;
    private String uploadPath;

    private String fileName;
    private String productid;
}
