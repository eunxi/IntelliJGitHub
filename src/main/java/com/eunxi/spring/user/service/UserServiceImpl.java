package com.eunxi.spring.user.service;

import com.sun.org.apache.xpath.internal.objects.XNull;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;

@Service
public class UserServiceImpl implements UserService{
    @Autowired
    private UserDAO userDao;

    @Override
    public String login_check(UserVO vo, HttpSession session) {
        String name = userDao.login_check(vo);

        if(name != null){
            session.setAttribute("user_id", vo.getUser_id());
            session.setAttribute("name", name);
        }
        return name;
    }

    @Override
    public void logout(HttpSession session) {
        session.invalidate(); // session 초기화
    }

    @Override
    public void register(UserVO vo) {
        userDao.register(vo);
    }
}
