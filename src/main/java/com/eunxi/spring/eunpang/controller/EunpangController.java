package com.eunxi.spring.eunpang.controller;

import com.eunxi.spring.commons.service.Criteria;
import com.eunxi.spring.eunpang.service.EunpangService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
    public String main(Model model, HttpServletRequest request, Criteria cri
            , @RequestParam(value="nowPage", required=false)String nowPage
            , @RequestParam(value="cntPerPage", required=false)String cntPerPage){
        System.out.println("EUN-PANG Main Controller");
        HttpSession session = request.getSession();

        Map<String, Object> p_map = new HashMap<>();

        List<Map<String, Object>> cate_list = eunpang.list_category(p_map);
        List<Map<String, Object>> product_list = eunpang.list_product(p_map);
        List<Map<String, Object>> cri_list = eunpang.select_product(cri); // cri 인식 불가

        System.out.println("cri_list 출력됨?");
        for(int i = 0; i < cri_list.size(); i++){
            System.out.println(cri_list.get(i));
        }

        int total = eunpang.product_cnt(p_map);
        System.out.println("total =" +total);

        if (nowPage == null && cntPerPage == null) {
            nowPage = "1";
            cntPerPage = "12";
        } else if (nowPage == null) {
            nowPage = "1";
        } else if (cntPerPage == null) {
            cntPerPage = "12";
        }

        cri = new Criteria(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
        System.out.println("cri : " + cri);

        model.addAttribute("cate_list", cate_list);
        model.addAttribute("session", session.getAttribute("user_id"));
        model.addAttribute("pro_list", product_list);
        model.addAttribute("paging", cri);
        model.addAttribute("viewAll", cri_list);


        return "/eunpang/main";
    }

    @GetMapping("/list")
    public String list(@RequestParam Map<String, Object> map, Model model, HttpServletRequest request){
        System.out.println("EuN-PANG List Controller");
        HttpSession session = request.getSession();
        model.addAttribute("session", session.getAttribute("user_id"));

        for(String key : map.keySet()){
            System.out.println("key : " + key + ", value : " + map.get(key));
        }

        List<Map<String, Object>> category1_product = eunpang.category1_product(map);
        List<Map<String, Object>> category2_product = eunpang.category2_product(map);

        if(!category1_product.isEmpty()){ // 1차
            model.addAttribute("pro_list", category1_product);
            return "/eunpang/main";
        }else if(!category2_product.isEmpty()){ // 2차
            model.addAttribute("pro_list", category2_product);
            return "/eunpang/main";
        }

        return "/eunpang/main";

    }










































}
