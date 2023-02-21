package com.eunxi.spring.eunpang.service;

import com.eunxi.spring.commons.service.Criteria;
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
    public List<Map<String, Object>> category1_product(Map<String, Object> map) {
        return eunpangDao.category1_product(map);
    }

    @Override
    public List<Map<String, Object>> category2_product(Map<String, Object> map) {
        return eunpangDao.category2_product(map);
    }

    @Override
    public int product_cnt(Map<String, Object> map) {
        return eunpangDao.product_cnt(map);
    }

    @Override
    public List<Map<String, Object>> select_product(Criteria cri) {
        System.out.println("serviceImpl --- " + eunpangDao.select_product(cri));
        return eunpangDao.select_product(cri);
    }
}
