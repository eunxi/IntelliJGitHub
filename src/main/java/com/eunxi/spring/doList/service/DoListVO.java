package com.eunxi.spring.doList.service;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

@Setter
@Getter
@ToString
public class DoListVO {
    private int d_seq; // do list 번호
    private String user_id; // 사용자
    private String d_content; // 할 일
    private String d_state; // 할 일 상태

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
    private Date d_start_date; // 시작 날짜

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
    private Date d_end_date; // 마지막 날짜
}
