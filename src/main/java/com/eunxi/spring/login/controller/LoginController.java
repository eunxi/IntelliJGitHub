package com.eunxi.spring.login.controller;

import com.eunxi.spring.login.service.LoginVO;
import com.eunxi.spring.user.service.UserService;
import com.eunxi.spring.user.service.UserVO;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;

@Controller // 로그인 처리 담당 컨트롤러
public class LoginController {

    @Autowired
    private UserService userService;

    // 로그인 화면
    @GetMapping("/")
    public String login(@ModelAttribute("login") LoginVO login){
        System.out.println("로그인 화면 Controller");

        return "/user/login";
    }

    // 로그인
    @PostMapping("/user/login")
    public void login(LoginVO login, HttpSession session, Model model, RedirectAttributes redirect){
        System.out.println("Login POST Controller");
        UserVO user = userService.login(login); // 화면으로부터 받은 데이터 중 id를 통해 select한 회원 정보를 user에 담기
        userService.last_login_day(login); // 로그인 날짜 업데이트

        // 비밀번호 null 이거나 검증해서 맞지 않으면 메서드 종료
        if(user == null || !BCrypt.checkpw(login.getUser_password(), user.getUser_password())){
            model.addAttribute("msg", "ERROR");
            return;
        }

        model.addAttribute("user", user); // 비밀번호 일치할 경우 user 저장
    }

    // 로그아웃
    @GetMapping("logout")
    public String logout(HttpSession session){
        System.out.println("Logout Controller");
        Object object = session.getAttribute("login");

        if(object != null){
            UserVO user = (UserVO)object;
            session.removeAttribute("login");
            session.invalidate();
        }

        return "/user/logout";
    }
}
