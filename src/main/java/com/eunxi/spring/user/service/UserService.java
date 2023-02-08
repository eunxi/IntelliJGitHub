package com.eunxi.spring.user.service;

import javax.servlet.http.HttpSession;

public interface UserService {
    public String login_check(UserVO vo, HttpSession session); // 로그인
    public void logout(HttpSession session); // 로그아웃
    public void register(UserVO vo);
}
