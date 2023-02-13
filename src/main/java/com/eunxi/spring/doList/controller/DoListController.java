package com.eunxi.spring.doList.controller;

import com.eunxi.spring.doList.service.DoListService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("/do")
public class DoListController {

    @Autowired
    private DoListService doService;

    @GetMapping("/doList")
    public String do_list(@RequestParam Map<String, Object> map, Model model, @RequestParam(value="type", defaultValue = "", required = false)String type,
                          @RequestParam(value="now", defaultValue = "", required = false)String now , HttpServletRequest request) throws ParseException {
        try {
            HttpSession session = request.getSession();
            System.out.println("user_id : " + session.getAttribute("user_id"));
            System.out.println("login : " + session.getAttribute("login"));
        }catch (Exception e){
            e.printStackTrace();

        }

        System.out.println("To Do List Controller");

        Map<String, Object> d_map = new HashMap<>();
        System.out.println("Do List Controller : " + doService.do_list(d_map));

        // 날짜 구하기
        Calendar cal = Calendar.getInstance();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String now_date = "";
        String pre_date = "";
        String next_date = "";

        if(now.isEmpty()){
            now_date = sdf.format(cal.getTime());

            cal.add(cal.DATE, -1);
            pre_date = sdf.format(cal.getTime());

            cal.add(cal.DATE, +2);
            next_date = sdf.format(cal.getTime());
        }else{
            if(type.equals("pre")){ // 이전
                cal.setTime(sdf.parse(now));

                cal.add(cal.DATE, -1);
                now_date = sdf.format(cal.getTime());

                cal.add(cal.DATE, -1);
                pre_date = sdf.format(cal.getTime());

                cal.add(cal.DATE, +2);
                next_date = sdf.format(cal.getTime());
            }else{
                if(type.equals("next")){
                    cal.setTime(sdf.parse(now));

                    cal.add(cal.DATE, +1);
                    now_date = sdf.format(cal.getTime());

                    cal.add(cal.DATE, -1);
                    pre_date = sdf.format(cal.getTime());

                    cal.add(cal.DATE, +2);
                    next_date = sdf.format(cal.getTime());
                }
            }
        }

        now = now_date;

        model.addAttribute("type",type);
        model.addAttribute("now", now);
        model.addAttribute("next_date", next_date);
        model.addAttribute("pre_date", pre_date);
        model.addAttribute("doList", doService.do_list(d_map));

        return "/doList/doList_main";
    }

    // 일정 추가
    @GetMapping("/doAdd")
    public String do_add(){
        System.out.println("Add GET Controller");

        return "/doList/doList_detail";
    }

    @PostMapping("/doAdd_action")
    @ResponseBody
    public String add_action(@RequestParam Map<String, Object> map, Model model){
        System.out.println("ADD Action POST Controller");

        Map<String, Object> do_map = new HashMap<>();
        do_map.put("d_start_date", map.get("start").toString());
        do_map.put("d_end_date", map.get("end").toString());
        do_map.put("d_content", map.get("content").toString());
        do_map.put("user_id", map.get("user").toString());

        doService.do_add(do_map);

        model.addAttribute("msg", "SUCCESS");

        return "redirect:/do/doList";
    }

    @GetMapping("/doDel")
    @ResponseBody
    public void do_delete(@RequestParam Map<String, Object> map){
        System.out.println("DELETE GET Controller");

        doService.do_delete(Integer.parseInt(map.get("seq").toString()));
    }

    @PostMapping("/doUpdate")
    @ResponseBody
    public void do_update(@RequestParam Map<String, Object> map){
        System.out.println("Update Post Controller");

        doService.do_finish(Integer.parseInt(map.get("seq").toString()));
    }
























}
