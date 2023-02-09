package com.eunxi.spring.commons.interceptor;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

// 특정 경로에 접근할 경우, 현재 사용자의 로그인 여부 체크
public class AuthInterceptor extends HandlerInterceptorAdapter {

    @Override // 로그인 상태여부 확인 후, 컨트롤러 호출 여부
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession();

        if(session.getAttribute("login") == null){
            response.sendRedirect("/");
            return false;
        }

        return true;
    }
}
