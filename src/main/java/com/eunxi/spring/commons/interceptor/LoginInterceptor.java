package com.eunxi.spring.commons.interceptor;

import com.eunxi.spring.user.service.UserVO;
import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

// HttpSession 관련 모든 설정 처리 - 로그인한 사용자에 대한 정보 저장
public class LoginInterceptor extends HandlerInterceptorAdapter {
    private static final String LOGIN = "login";

    @Override // session에 컨트롤러에서 저장한 user 저장, /index 리다이렉트
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        HttpSession session = request.getSession();
        ModelMap modelMap = modelAndView.getModelMap();
        UserVO userVO = (UserVO) modelMap.get("user");

        if(userVO != null){
            session.setAttribute(LOGIN, userVO);
            session.setAttribute("user_id" , userVO.getUser_id());
            response.sendRedirect("/index");
        }
    }

    @Override // 기존의 로그인 정보가 있을 경우, 초기화
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession();

        // 기존의 로그인 정보 제거
        if(session.getAttribute(LOGIN) != null){
            session.removeAttribute(LOGIN);
        }

        return true;
    }
}
