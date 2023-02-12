package com.eunxi.spring.doList.service;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

@Setter
@Getter
@ToString
public class DoDate {
    private String year = "";
    private String month = "";
    private String date = "";
    private String value = "";

    private String start_date = "";
    private String end_date = "";

    public String getYear() {
        return year;
    }

    public void setYear(String year) {
        this.year = year;
    }

    public String getMonth() {
        return month;
    }

    public void setMonth(String month) {
        this.month = month;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public String getStart_date() {
        return start_date;
    }

    public void setStart_date(String start_date) {
        this.start_date = start_date;
    }

    public String getEnd_date() {
        return end_date;
    }

    public void setEnd_date(String end_date) {
        this.end_date = end_date;
    }

    // 날짜 관련 달력 정보 메서드
    public Map<String, Integer> today_info(DoDate doDate){
        // 날짜 캘린더 함수에 삽입
        Map<String, Integer> today_map = new HashMap<>();
        Calendar cal = Calendar.getInstance();
        cal.set(Integer.parseInt(doDate.getYear()), Integer.parseInt(doDate.getMonth()), 1);

        int start_day = cal.getMaximum(Calendar.DATE);
        int end_day = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
        int start = cal.get(Calendar.DAY_OF_WEEK);

        Calendar today_cal = Calendar.getInstance();
        SimpleDateFormat ysdf = new SimpleDateFormat("yyyy");
        SimpleDateFormat msdf = new SimpleDateFormat("M");

        int today_year = Integer.parseInt(ysdf.format(today_cal.getTime()));
        int today_month = Integer.parseInt(msdf.format(today_cal.getTime()));
        int search_year = Integer.parseInt(doDate.getYear());
        int search_month = Integer.parseInt(doDate.getMonth() + 1);

        int today = -1;
        if(today_year == search_year && today_month == search_month){
            SimpleDateFormat dsdf = new SimpleDateFormat("dd");
            today = Integer.parseInt(dsdf.format(today_cal.getTime()));
        }

        search_month = search_month - 1;

        Map<String, Integer> before_after_calendar = before_after_calendar(search_year, search_month);

        // 날짜 관련
        System.out.println("search_month : " + search_month);

        // 캘린더 함수 end
        today_map.put("start", start);
        today_map.put("start_day", start_day);
        today_map.put("end_day", end_day);
        today_map.put("today", today);
        today_map.put("search_year", search_year);
        today_map.put("search_month", search_month);
        today_map.put("before_year", before_after_calendar.get("before_year"));
        today_map.put("before_month", before_after_calendar.get("before_month"));
        today_map.put("after_year", before_after_calendar.get("after_year"));
        today_map.put("after_month", before_after_calendar.get("after_month"));

        this.start_date = String.valueOf(search_year) + "-" + String.valueOf(search_month + 1) + "-" + String.valueOf(start_day);
        this.end_date = String.valueOf(search_year) + "-" + String.valueOf(search_month + 1) + "-" + String.valueOf(end_day);

        return today_map;
    }

    // 이전달, 다음달 및 이전년도, 다음년도
    private Map<String, Integer> before_after_calendar(int search_year, int search_month){
        Map<String, Integer> before_after_data = new HashMap<>();

        int before_year = search_year;
        int before_month = search_month - 1;
        int after_year = search_year;
        int after_month = search_month + 1;

        if(before_month < 0){
            before_month = 11;
            before_year = search_year - 1;
        }

        if(after_month > 11){
            after_month = 0;
            after_year = search_year + 1;
        }

        before_after_data.put("before_year", before_year);
        before_after_data.put("before_month", before_month);
        before_after_data.put("after_year", after_year);
        before_after_data.put("after_month", after_month);

        return before_after_data;
    }

    // 스케줄 사용시 사용될 생성자
    public DoDate(String year, String month, String date, String value){
        if((month != null && month != "") && (date != null && date != "")){
            this.year = year;
            this.month = month;
            this.date = date;
            this.value = value;
        }
    }

    public DoDate(){

    }



































}
