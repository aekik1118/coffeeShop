package com.coffeeshop.mapper;

import com.coffeeshop.domain.ProductAttachVO;

public interface ProductAttachMapper {
    public void insert(ProductAttachVO vo);
    public void delete(String productid);
    public void update(ProductAttachVO vo);
    public ProductAttachVO getAttach(String productid);
}
