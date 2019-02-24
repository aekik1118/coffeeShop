package com.coffeeshop.domain;

import lombok.Data;

@Data
public class ProductAttachDTO {
    private String fileName;
    private String uploadPath;
    private String uuid;
}
