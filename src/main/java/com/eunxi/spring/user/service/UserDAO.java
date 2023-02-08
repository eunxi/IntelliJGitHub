package com.eunxi.spring.user.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class UserDAO {
    @Autowired
    private SqlSessionTemplate session;

    // 로그인
    public String login_check(UserVO vo){
        return session.selectOne("userDao.login_check", vo);
    }

    // 회원가입
    public void register(UserVO vo){
        session.insert("userDao.register", vo);
    }
}
