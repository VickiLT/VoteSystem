package com.vote.controller;

import com.vote.entity.BusinessException;
import com.vote.entity.CustomException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by sunwe on 2018/3/31.
 */
@ControllerAdvice
public class GlobalExceptionHandler {
    //处理自定义的异常
    @ExceptionHandler(BusinessException.class)
    @ResponseBody
    public Map<String, Object> handleAndReturnData(HttpServletRequest request, HttpServletResponse response, BusinessException ex) {

        Map<String, Object> data = new HashMap<String, Object>();
        data.put("msg", ex.getMessage());
        data.put("success", false);
        data.put("data", null);
        return data;
    }

    @ExceptionHandler(CustomException.class)
    public String customException(CustomException ex, Model model){
        model.addAttribute("msg",ex.getMessage());
        return "error";
    }
    //其他未处理的异常
    @ExceptionHandler(Exception.class)
    public Object exceptionHandler(Exception e,Model model){
        model.addAttribute("msg",e.getMessage());
        return "error";
    }

}
