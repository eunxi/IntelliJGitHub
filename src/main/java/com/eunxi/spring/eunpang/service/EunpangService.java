package com.eunxi.spring.eunpang.service;

import com.eunxi.spring.commons.service.Criteria;

import java.util.List;
import java.util.Map;

public interface EunpangService {
    // 카테고리
    List<Map<String, Object>> list_cate1(Map<String, Object> map);
    List<Map<String, Object>> list_cate2(Map<String, Object> map);

    // 카테고리 - 상품
    List<Map<String, Object>> category1_product(Map<String, Object> map, Criteria cri);
    List<Map<String, Object>> category2_product(Map<String, Object> map, Criteria cri);
    int category1_cnt(Map<String, Object> map);
    int category2_cnt(Map<String, Object> map);

    // 메인 상품
    int product_cnt(Map<String, Object> map);
    List<Map<String, Object>> select_product(Criteria cri);

    // 상품 상세
    Map<String, Object> pro_detail(Map<String, Object> map);

    // 카테고리 코드만 구해오기
    Map<String, Object> cate(Map<String, Object> map);

}
