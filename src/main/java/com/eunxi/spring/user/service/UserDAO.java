package com.eunxi.spring.user.service;

import com.eunxi.spring.login.service.LoginVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class UserDAO {
    @Autowired
    private SqlSessionTemplate session;

    // 회원가입
    public void register(UserVO vo){
        session.insert("userDao.user_register", vo);
    }

    // 로그인
    public UserVO login(LoginVO login){
        return session.selectOne("userDao.login", login);
    }

    // 최근 로그인 날짜
    public void last_login_day(LoginVO login){
        session.update("userDao.last_login_day", login);
    }



























}
