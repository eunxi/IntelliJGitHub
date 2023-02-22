package com.eunxi.spring.eunpang.service;

import com.eunxi.spring.commons.service.Criteria;
import org.apache.ibatis.session.RowBounds;
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

    // 카테고리별 상품 출력 1차 분류
    public List<Map<String, Object>> category1_product(Map<String, Object> map, Criteria cri){
        int limit = cri.getCntPerPage();
        int offset = (cri.getNowPage() - 1) * limit;

        RowBounds rowBounds = new RowBounds(offset, limit);
        return session.selectList("eunpangDao.category1_product", map, rowBounds);
    }

    // 카테고리별 상품 출력 2차 분류
    public List<Map<String, Object>> category2_product(Map<String, Object> map, Criteria cri){
        int limit = cri.getCntPerPage();
        int offset = (cri.getNowPage() - 1) * limit;

        RowBounds rowBounds = new RowBounds(offset, limit);
        return session.selectList("eunpangDao.category2_product", map, rowBounds);
    }

    public int product_cnt(Map<String, Object> map){
        return session.selectOne("eunpangDao.product_cnt", map);
    }

    public List<Map<String, Object>> select_product(Criteria cri){
        System.out.println("cri ??" + cri);
        int limit = cri.getCntPerPage();
        int offset = (cri.getNowPage() - 1) * limit;
        System.out.println("limit = " + limit + ", offset = " + offset);

        return session.selectList("eunpangDao.select_product", cri);
    }

    public int category1_cnt(Map<String, Object> map){
        return session.selectOne("eunpangDao.category1_cnt", map);
    }

    public int category2_cnt(Map<String, Object> map){
        return session.selectOne("eunpangDao.category2_cnt", map);
    }
}
