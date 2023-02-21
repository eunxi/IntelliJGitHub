package com.eunxi.spring.eunpang.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class EunpangServiceImpl implements EunpangService {
    @Autowired
    private EunpangDAO eunpangDao;

    @Override
    public List<Map<String, Object>> list_category(Map<String, Object> map) {
        return eunpangDao.list_category(map);
    }

    @Override
    public List<Map<String, Object>> list_product(Map<String, Object> map) {
        return eunpangDao.list_product(map);
    }

    @Override
    public List<Map<String, Object>> get_image() {
        return eunpangDao.get_image();
    }
}
