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

    // 은팡 - 메인
    @GetMapping("/")
    public String main(Model model, HttpServletRequest request
            , @RequestParam(value = "nowPage", required = false) String nowPage
            , @RequestParam(value = "cntPerPage", required = false) String cntPerPage, Criteria criteria) {
        System.out.println("EUN-PANG Main Controller");
        HttpSession session = request.getSession();

        Map<String, Object> p_map = new HashMap<>();

        if (nowPage == null && cntPerPage == null) {
            nowPage = "1";
            cntPerPage = "12";
        } else if (nowPage == null) {
            nowPage = "1";
        } else if (cntPerPage == null) {
            cntPerPage = "12";
        }

        int total = eunpang.product_cnt(p_map);
        criteria = new Criteria(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));

        List<Map<String, Object>> cri_list = eunpang.select_product(criteria); // 상품 목록 + 페이징

        model.addAttribute("pro_list", cri_list); // 목록 + 페이징
        model.addAttribute("session", session.getAttribute("user_id")); // 세션
        model.addAttribute("paging", criteria); // 페이징

        // 검색할 때 데이터들
        System.out.println("total total : " + total);
        System.out.println("criteria keyword : " + criteria.getKeyword());
        System.out.println("criteria type : " + criteria.getType());

        return "/eunpang/main";
    }

    // 은팡 - 카테고리
    @GetMapping("/list")
    public String list(
            @RequestParam(value = "nowPage", required = false) String nowPage
            , @RequestParam(value = "cntPerPage", required = false) String cntPerPage
            , @RequestParam Map<String, Object> map, Model model, HttpServletRequest request) {
        System.out.println("EuN-PANG List Controller");
        HttpSession session = request.getSession();
        model.addAttribute("session", session.getAttribute("user_id"));

        if (nowPage == null && cntPerPage == null) {
            nowPage = "1";
            cntPerPage = "12";
        } else if (nowPage == null) {
            nowPage = "1";
        } else if (cntPerPage == null) {
            cntPerPage = "12";
        }

        int cate1_cnt = eunpang.category1_cnt(map);
        Criteria cri = new Criteria(cate1_cnt, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
        List<Map<String, Object>> category1_product = eunpang.category1_product(map, cri);

        int cate2_cnt = eunpang.category2_cnt(map);
        Criteria cri2 = new Criteria(cate2_cnt, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
        List<Map<String, Object>> category2_product = eunpang.category2_product(map, cri2);

        if (!category1_product.isEmpty()) { // 1차
            model.addAttribute("pro_list", category1_product);
            model.addAttribute("paging", cri);
        } else if (!category2_product.isEmpty()) { // 2차
            model.addAttribute("pro_list", category2_product);
            model.addAttribute("paging", cri2);
        }

        return "/eunpang/main";
    }


}
