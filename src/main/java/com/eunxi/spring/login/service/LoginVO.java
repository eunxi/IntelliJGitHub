package com.eunxi.spring.login.service;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

@Setter
@Getter
@ToString
public class LoginVO { // 로그인 화면으로부터 전달되는 회원의 데이터를 수집하는 용도
    private String user_id;
    private String user_password;
    private Boolean user_cookie;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
    private Date login_day;
}
