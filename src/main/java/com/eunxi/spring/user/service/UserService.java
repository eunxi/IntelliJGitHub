package com.eunxi.spring.user.service;

import com.eunxi.spring.login.service.LoginVO;

import javax.servlet.http.HttpSession;

public interface UserService {
    public void user_register(UserVO vo); // 회원가입
    public UserVO login(LoginVO login); // 로그인
    public void last_login_day(LoginVO login); // 마지막 로그인 날짜




}
