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
            , @RequestParam(value = "cntPerPage", required = false) String cntPerPage
            , @RequestParam Map<String, Object> map
            , Criteria criteria) {
        System.out.println("EUN-PANG Main Controller");
        HttpSession session = request.getSession();

        if (nowPage == null && cntPerPage == null || nowPage == "0" && cntPerPage == "0") {
            nowPage = "1";
            cntPerPage = "12";
        } else if (nowPage == null || nowPage == "0") {
            nowPage = "1";
        } else if (cntPerPage == null || cntPerPage == "0") {
            cntPerPage = "12";
        }

        int total = eunpang.product_cnt(map);
        criteria = new Criteria(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));

        List<Map<String, Object>> cri_list = eunpang.select_product(criteria); // 상품 목록 + 페이징
        List<Map<String, Object>> list_cate1 = eunpang.list_cate1(map); // 카테고리만 출력

        // 1차
        int cate1_total1 = eunpang.category1_cnt(map);
        Criteria cri1 = new Criteria(cate1_total1, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
        List<Map<String, Object>> category1_product = eunpang.category1_product(map, cri1);

        // 2차
        int cate1_total2 = eunpang.category2_cnt(map);
        Criteria cri2 = new Criteria(cate1_total2, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
        List<Map<String, Object>> category2_product = eunpang.category2_product(map, cri2);

        if (!category1_product.isEmpty()) { // 1차
            model.addAttribute("pro_list", category1_product);
            model.addAttribute("criteria", cri1);
        } else if (!category2_product.isEmpty()) { // 2차
            model.addAttribute("pro_list", category2_product);
            model.addAttribute("criteria", cri2);
        }else{
            model.addAttribute("pro_list", cri_list); // 목록 + 페이징
            model.addAttribute("criteria", criteria); // 페이징
        }

        // 검색할 때 데이터들
        System.out.println("total total : " + total);
        System.out.println("total cate1_total : " + cate1_total1);
        System.out.println("total cate1_total2 : " + cate1_total2);
        System.out.println("criteria keyword : " + criteria.getKeyword());
        System.out.println("criteria type : " + criteria.getType());
        System.out.println("cate : " + eunpang.cate(map));
//        System.out.println("criteria type : " + criteria.getType());

        // model
        model.addAttribute("list_cate1", list_cate1); // 카테고리
        model.addAttribute("cate", eunpang.cate(map)); // 2차 카테고리 상세
        model.addAttribute("pc_codeRef" , map.get("pc_codeRef")); // 현재 상위 카테고리
        model.addAttribute("session", session.getAttribute("user_id")); // 세션

        return "/eunpang/main";
    }

    // 상세보기
    @GetMapping("/detail")
    public String detail(@RequestParam Map<String, Object> map, Model model, HttpServletRequest request){
        System.out.println("EUN-PANG Detail Controller");
        HttpSession session = request.getSession();
        model.addAttribute("session", session.getAttribute("user_id"));

        for(String key : map.keySet()){
            System.out.println("key : " + key + ", value : " + map.get(key));
        }

        System.out.println("출력 ---> " + eunpang.pro_detail(map));
        System.out.println("1차 카테고리 ---> " + eunpang.list_cate1(map));
        System.out.println("2차 카테고리 ---> " + eunpang.list_cate2(map));

        model.addAttribute("detail", eunpang.pro_detail(map));






        return "/eunpang/detail";
    }




































}
