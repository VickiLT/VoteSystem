package com.vote.util;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Created by sunwe on 2018/3/13.
 */
public class LoginHandlerInterceptor implements HandlerInterceptor {

    @Override
    public void afterCompletion(HttpServletRequest request,
                                HttpServletResponse response, Object arg2, Exception arg3)
            throws Exception {
    }

    @Override
    public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1,
                           Object arg2, ModelAndView arg3) throws Exception {

    }

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse arg1,
                             Object arg2) throws Exception {
        String requestURI = request.getRequestURI();
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        //获取当前请求的路径
        String basePath = request.getScheme() + "://" + request.getServerName() + ":"  + request.getServerPort()+request.getContextPath();
        if (username != null) {
            //登陆成功的用户
            return true;
        } else {
            //没有登陆，转向登陆界面
            if (request.getHeader("x-requested-with") != null && request.getHeader("x-requested-with").equalsIgnoreCase("XMLHttpRequest")){ //如果是ajax请求响应头会有x-requested-with
                arg1.setHeader("REDIRECT", "REDIRECT");
                //告诉ajax我重定向的路径
                arg1.setHeader("CONTEXTPATH",basePath+"/user/noLogin2Login");
                arg1.setStatus(HttpServletResponse.SC_FORBIDDEN);
                return false;
            }else {
                String msg = "用户未登录！";
                arg1.getWriter().write("<script>window.top.location.href=\"/jsp/login.jsp?msg=" + msg + "\"</script>");
                return false;
            }
        }
    }
}

