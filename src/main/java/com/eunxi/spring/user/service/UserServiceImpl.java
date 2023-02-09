package com.eunxi.spring.user.service;

import com.eunxi.spring.login.service.LoginVO;
import com.sun.org.apache.xpath.internal.objects.XNull;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;

@Service
public class UserServiceImpl implements UserService{
    @Autowired
    private UserDAO userDao;

    @Override
    public void user_register(UserVO vo) {
        userDao.register(vo);
    }

    @Override
    public UserVO login(LoginVO login) {
        return userDao.login(login);
    }

    @Override
    public void last_login_day(LoginVO login) {
        userDao.last_login_day(login);
    }
}
