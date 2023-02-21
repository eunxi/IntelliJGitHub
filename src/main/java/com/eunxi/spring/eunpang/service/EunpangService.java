package com.eunxi.spring.eunpang.service;

import java.util.List;
import java.util.Map;

public interface EunpangService {
    List<Map<String, Object>> list_category(Map<String, Object> map);
    List<Map<String, Object>> list_product(Map<String, Object> map);
    List<Map<String, Object>> get_image();





}
