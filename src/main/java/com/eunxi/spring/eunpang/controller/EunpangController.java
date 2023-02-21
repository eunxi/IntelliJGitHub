package com.eunxi.spring.eunpang.controller;

import com.eunxi.spring.eunpang.service.EunpangService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/eunpang")
public class EunpangController {

    @Autowired
    private EunpangService eunpang;

    @GetMapping("/")
    public String main(Model model, HttpServletRequest request){
        System.out.println("EUN-PANG Main Controller");
        Map<String, Object> map = new HashMap<>();

        HttpSession session = request.getSession();

        List<Map<String, Object>> cate_list = eunpang.list_category(map);
        System.out.println("은팡 카테고리 목록 출력");
        for(int i = 0; i < cate_list.size(); i++){
            System.out.println(cate_list.get(i));
        }

        List<Map<String, Object>> product_list = eunpang.list_product(map);
        System.out.println("은팡 상품 목록 출력");
        for(int i = 0; i < product_list.size(); i++){
            System.out.println(product_list.get(i));
        }

        model.addAttribute("cate_list", cate_list);
        model.addAttribute("session", session.getAttribute("user_id"));
        model.addAttribute("pro_list", product_list);

        return "/eunpang/main";
    }












































}
