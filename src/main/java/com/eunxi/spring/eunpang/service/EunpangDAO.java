package com.eunxi.spring.eunpang.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class EunpangDAO {
    @Autowired
    private SqlSessionTemplate session;

    // 카테고리
    public List<Map<String, Object>> list_category(Map<String, Object> map){
        return session.selectList("eunpangDao.list_category", map);
    }

    // 상품 목록
    public List<Map<String, Object>> list_product(Map<String, Object> map){
        return session.selectList("eunpangDao.list_product", map);
    }

    // 이미지만 출력
    public List<Map<String, Object>> get_image(){
        return session.selectList("eunpangDao.get_image");
    }
}
