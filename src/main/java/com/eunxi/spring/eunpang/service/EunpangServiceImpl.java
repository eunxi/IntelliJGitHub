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
    public List<Map<String, Object>> list_cate1(Map<String, Object> map) {
        return eunpangDao.list_cate1(map);
    }

    @Override
    public List<Map<String, Object>> list_cate2(Map<String, Object> map) {
        return eunpangDao.list_cate1(map);
    }

    @Override
    public List<Map<String, Object>> category1_product(Map<String, Object> map, Criteria cri) {
        return eunpangDao.category1_product(map, cri);
    }

    @Override
    public List<Map<String, Object>> category2_product(Map<String, Object> map, Criteria cri) {
        return eunpangDao.category2_product(map, cri);
    }

    @Override
    public int product_cnt(Map<String, Object> map) {
        return eunpangDao.product_cnt(map);
    }

    @Override
    public List<Map<String, Object>> select_product(Criteria cri) {
        return eunpangDao.select_product(cri);
    }

    @Override
    public int category1_cnt(Map<String, Object> map) {
        return eunpangDao.category1_cnt(map);
    }

    @Override
    public int category2_cnt(Map<String, Object> map) {
        return eunpangDao.category2_cnt(map);
    }

    @Override
    public Map<String, Object> pro_detail(Map<String, Object> map) {
        return eunpangDao.pro_detail(map);
    }

    @Override
    public Map<String, Object> cate(Map<String, Object> map) {
        return eunpangDao.cate(map);
    }

}
