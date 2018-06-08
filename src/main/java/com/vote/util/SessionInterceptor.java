package com.vote.util;

import com.vote.entity.Person;
import com.vote.service.Impl.SessionServiceImpl;
import com.vote.service.SessionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.net.URLEncoder;

/**
 * Created by sunwe on 2018/3/31.
 */
public class SessionInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o) throws Exception {
        SessionServiceImpl sessionService = new SessionServiceImpl();
        HttpSession session = httpServletRequest.getSession();
        Person person = (Person) session.getAttribute("person");
        String identity=(String)session.getAttribute("identity");
        Boolean flag  = sessionService.checkLoginIsMe(person);
        //获取当前请求的路径
        String basePath = httpServletRequest.getScheme() + "://" + httpServletRequest.getServerName() + ":"  + httpServletRequest.getServerPort()+httpServletRequest.getContextPath();
        if(!flag)   {
            if (httpServletRequest.getHeader("x-requested-with") != null && httpServletRequest.getHeader("x-requested-with").equalsIgnoreCase("XMLHttpRequest")){ //如果是ajax请求响应头会有x-requested-with
                session.invalidate();
                httpServletResponse.setHeader("REDIRECT", "REDIRECT");
                //告诉ajax我重定向的路径
                httpServletResponse.setHeader("CONTEXTPATH",basePath+"/user/toLogin");
                httpServletResponse.setStatus(HttpServletResponse.SC_FORBIDDEN);
                return false;
            }else {

                session.invalidate();
                String msg = "用户已在别处登录，您已被迫下线！";
                if(identity.equals("admin")){
                    httpServletResponse.getWriter().write("<script>window.top.location.href=\"/jsp/adminLogin.jsp?msg=" + msg + "\"</script>");
                }else{
                    httpServletResponse.getWriter().write("<script>window.top.location.href=\"/jsp/login.jsp?msg=" + msg + "\"</script>");
                }

                return false;
            }
        }
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }
}
