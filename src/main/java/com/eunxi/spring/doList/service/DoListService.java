package com.eunxi.spring.doList.service;

import java.util.List;
import java.util.Map;

public interface DoListService {
    int do_add(Map<String, Object> map); // 일정 추가
    List<Map<String, Object>> do_list(Map<String, Object> map); // 일정 조회







}
