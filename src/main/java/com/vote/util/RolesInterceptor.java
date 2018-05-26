package com.vote.util;

import com.vote.entity.CustomException;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Map;
import java.util.Set;

/**
 * Created by sunwe on 2018/3/28.
 */
public class RolesInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o) throws Exception {
        String requestURI = httpServletRequest.getRequestURI();
        HttpSession session = httpServletRequest.getSession();
        String identity = (String) session.getAttribute("identity");
        String basePath = httpServletRequest.getScheme() + "://" + httpServletRequest.getServerName() + ":"  + httpServletRequest.getServerPort()+httpServletRequest.getContextPath();
        String identityId = "";
        if(identity.equals("manager"))
            identityId = "1";
        else if(identity.equals("user"))
            identityId = "2";
        else identityId = "3";
        int pos = requestURI.indexOf("?");
        String matchUrl = requestURI;
        if(pos!=-1){
            matchUrl = requestURI.substring(0,pos);
        }
        Map<String,Set<String>> resourceMap = (Map<String, Set<String>>) httpServletRequest.getServletContext().getAttribute("resourceMap");
        if(matchUrl.contains("/frame")){
            return true;
        }else if(matchUrl.contains("/manage/")){
            if(identityId.equals("1"))
                return true;
            else {
                if (httpServletRequest.getHeader("x-requested-with") != null && httpServletRequest.getHeader("x-requested-with").equalsIgnoreCase("XMLHttpRequest")){ //如果是ajax请求响应头会有x-requested-with
                    httpServletResponse.setHeader("REDIRECT", "REDIRECT1");
                    httpServletResponse.setHeader("CONTEXTPATH",basePath+"/frame/toError");
                    httpServletResponse.setStatus(HttpServletResponse.SC_FORBIDDEN);
                    return false;
                }else {
                    httpServletResponse.getWriter().write("<script>window.location.href=\"/jsp/roleserror.jsp\"</script>");
                    return false;
                }
            }
        }else {
            Set<String> permission = resourceMap.get(matchUrl);
            if(permission.contains(identityId)){
                return true;
            }else {
                if (httpServletRequest.getHeader("x-requested-with") != null && httpServletRequest.getHeader("x-requested-with").equalsIgnoreCase("XMLHttpRequest")){ //如果是ajax请求响应头会有x-requested-with
                    httpServletResponse.setHeader("REDIRECT", "REDIRECT1");
                    httpServletResponse.setHeader("CONTEXTPATH",basePath+"/frame/toError");
                    httpServletResponse.setStatus(HttpServletResponse.SC_FORBIDDEN);
                    return false;
                }else {
                    httpServletResponse.getWriter().write("<script>window.location.href=\"/jsp/roleserror.jsp\"</script>");
                    return false;
                }
            }
        }
    }

    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }
}
