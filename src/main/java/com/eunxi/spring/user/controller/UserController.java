package com.eunxi.spring.user.controller;

import com.eunxi.spring.user.service.UserService;
import com.eunxi.spring.user.service.UserVO;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;

@Controller
public class UserController {

    @Autowired
    private UserService userService;

    // 로그인 화면
    @GetMapping("/")
    public String login(){
        System.out.println("Login Controller");

        return "/login/login";
    }

    // 로그인
    @PostMapping("login_check")
    public ModelAndView login_check(@ModelAttribute UserVO vo, HttpSession session){
        String name = userService.login_check(vo, session);
        ModelAndView mav = new ModelAndView();
        if(name != null){ // 로그인 성공
            mav.setViewName("index");
        }else{
            mav.setViewName("/login/login");
            mav.addObject("msg", "ERROR");
        }

        return mav;
    }

    // 로그아웃
    @PostMapping("logout")
    public ModelAndView logout(HttpSession session, ModelAndView mav){
        userService.logout(session);
        mav.setViewName("/login/login"); // 응답할 view 이름 설정
        return mav;
    }

    // 회원가입
    @GetMapping("register")
    public String register(){
        return "/login/register";
    }

    // 회원가입 처리
    @PostMapping("register_action")
    public String register_action(UserVO vo, RedirectAttributes redirect){

        // 암호화할 비밀번호, 암호화된 비밀번호 리턴
        String hash_pw = BCrypt.hashpw(vo.getUser_password(), BCrypt.gensalt());
        vo.setUser_password(hash_pw);
        userService.register(vo);

        redirect.addFlashAttribute("msg", "SUCCESS");

        return "redirect:/login/login";
    }







































}
