package com.eunxi.spring.doList.controller;

import com.eunxi.spring.doList.service.DoDate;
import com.eunxi.spring.doList.service.DoListService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@Controller
@RequestMapping("/do")
public class DoListController {

    @Autowired
    private DoListService doService;

    @GetMapping("/doList")
    public String do_list(@RequestParam Map<String, Object> map, Model model){
        System.out.println("To Do List Controller");

        Map<String, Object> d_map = new HashMap<>();
        System.out.println("Do List Controller : " + doService.do_list(d_map));
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

    // 달력
    @GetMapping("/calendar")
    public String calendar(DoDate doDate, Model model) {
        Calendar cal = Calendar.getInstance();
        DoDate calendarData;

        // 검색 날짜
        if (doDate.getDate().equals("") && doDate.getMonth().equals("")) {
            doDate = new DoDate(String.valueOf(cal.get(Calendar.YEAR)), String.valueOf(cal.get(Calendar.MONTH)), String.valueOf(cal.get(Calendar.DATE)), null);
        }

        Map<String, Integer> today_info = doDate.today_info(doDate);
        List<DoDate> date_list = new ArrayList<>();

        // 실질적인 달력 데이터 리스트에 데이터 삽입
        for(int i = 1; i < today_info.get("start"); i++){
            calendarData = new DoDate(null, null, null, null);
            date_list.add(calendarData);
        }

        // 날짜 삽입
        for(int i = today_info.get("start_day"); i <= today_info.get("end_day"); i++){
            if(i == today_info.get("today")){
                calendarData = new DoDate(String.valueOf(doDate.getYear()), String.valueOf(doDate.getMonth()), String.valueOf(i), String.valueOf(doDate.getValue()));
            }else{
                calendarData = new DoDate(String.valueOf(doDate.getYear()), String.valueOf(doDate.getMonth()), String.valueOf(i), String.valueOf(doDate.getValue()));
            }

            date_list.add(calendarData);
        }

        // 달력 빈 곳에 빈 데이터 삽입
        int index = 7 - date_list.size() % 7;

        if(date_list.size() % 7 != 0){
            for(int i = 0; i < index; i++){
                calendarData = new DoDate(null, null, null, null);
                date_list.add(calendarData);
            }
        }

        System.out.println("date_list = " + date_list);

        // 배열에 담기
        model.addAttribute("date_list", date_list);
        model.addAttribute("today_info", today_info);

        return "/doList/doList_main";
    }


























}
