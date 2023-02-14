package com.eunxi.spring.user.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpSession;

@Controller
public class HomeController {

    @GetMapping("/index")
    public String home(HttpSession session, Model model){
        System.out.println("Home Controller");
        model.addAttribute("session", session.getAttribute("user_id"));

        return "index";
    }
}
