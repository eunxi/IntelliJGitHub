package com.eunxi.spring.eunpang.service;

import com.eunxi.spring.commons.service.Criteria;

import java.util.List;
import java.util.Map;

public interface EunpangService {
    List<Map<String, Object>> list_category(Map<String, Object> map);
    List<Map<String, Object>> category1_product(Map<String, Object> map, Criteria cri);
    List<Map<String, Object>> category2_product(Map<String, Object> map, Criteria cri);

    int product_cnt(Map<String, Object> map);
    List<Map<String, Object>> select_product(Criteria cri);

    int category1_cnt(Map<String, Object> map);
    int category2_cnt(Map<String, Object> map);


}
