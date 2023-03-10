package com.eunxi.spring.doList.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class DoListDAO {

    @Autowired
    private SqlSessionTemplate session;

    public int do_add(Map<String, Object> map){
        return session.insert("doDao.do_add", map);
    }

    public List<Map<String, Object>> do_list(Map<String, Object> map){
        return session.selectList("doDao.do_list", map);
    }

    public void do_delete(int d_seq){
        session.update("doDao.do_delete", d_seq);
    }

    public void do_finish(int d_seq){
        session.update("doDao.do_finish", d_seq);
    }
}
