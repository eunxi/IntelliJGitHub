package com.eunxi.spring.doList.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service
public class DoListServiceImpl implements  DoListService{

    @Autowired
    private DoListDAO doListDao;

    @Override
    public int do_add(Map<String, Object> map) {
        return doListDao.do_add(map);
    }

    @Override
    public List<Map<String, Object>> do_list(Map<String, Object> map) {
        List<Map<String, Object>> result = new ArrayList<>();
        result = doListDao.do_list(map);
        System.out.println("DoListServiceImpl = " + result);
        return result;
//        return doListDao.do_list(map);
    }
}
