package com.eunxi.spring.user.controller;

import com.eunxi.spring.user.service.UserService;
import com.eunxi.spring.user.service.UserVO;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/register")
public class UserController {

    @Autowired
    private UserService userService;

    // 회원가입
    @GetMapping("/register")
    public String register(){
        System.out.println("Register Controller");

        return "/user/register";
    }

    // 회원가입 처리
    @PostMapping("/register_action")
    public String register_action(UserVO vo, RedirectAttributes redirect){
        System.out.println("Register Action Controller");

        // 암호화할 비밀번호, 암호화된 비밀번호 리턴
        String hash_pw = BCrypt.hashpw(vo.getUser_password(), BCrypt.gensalt());
        vo.setUser_password(hash_pw);
        userService.user_register(vo);

        redirect.addFlashAttribute("msg", "SUCCESS");

        return "redirect:/";
    }








































}
