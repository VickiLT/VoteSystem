package com.vote.util;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by sunwe on 2018/3/28.
 */
public class VoteInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o) throws Exception {

        String requestUrl = httpServletRequest.getRequestURI().replace(httpServletRequest.getContextPath(), "");
        String identity = (String) httpServletRequest.getSession().getAttribute("identity");
        if(requestUrl.equals("/vote/vote")){
            if(identity.equals("secretary")){
                httpServletResponse.sendRedirect("/frame/toError");
                return false;
            }else {
                return true;
            }
        }
        if(requestUrl.contains("/vote/delete")||requestUrl.contains("/vote/manageVote")){
            if(identity.equals("user")){
                httpServletResponse.sendRedirect("/frame/toError");
                return false;
            }else {
                return true;
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
