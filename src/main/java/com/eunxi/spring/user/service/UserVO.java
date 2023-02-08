package com.eunxi.spring.user.service;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

@Setter
@Getter
@ToString
public class UserVO {
    private String user_id;
    private String user_password;
    private String user_name;
    private String user_phone;
    private String user_email;
    private String user_role; // M; 일반, A; 관리자
    private String user_state; // Y; 사용, N; 미사용

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
    private Date user_login_day; // 최근 로그인 날짜

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
    private Date user_join_day; // 가입 날짜

}
