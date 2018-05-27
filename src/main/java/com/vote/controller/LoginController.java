package com.vote.controller;

import com.vote.entity.*;
import com.vote.service.*;
import com.vote.service.Impl.KeyServiceImpl;
import com.vote.util.MD5Util;
import com.vote.util.MailUtil;
import com.vote.util.SessionListener;
import org.aspectj.apache.bcel.verifier.VerifierFactoryObserver;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.rmi.CORBA.Util;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

/**
 * login控制层
 * Created by sunwe on 2018/3/8.
 */
@Controller
@RequestMapping("/user")
public class LoginController {

    @Autowired
    private KeyService keyService;

    @Autowired
    private UserService userService;

    @Autowired
    private ManagerService managerService;

    @Autowired
    private SecretaryService secretaryService;

    @Autowired
    private VoteProjectService voteProjectService;

    @Autowired
    private SessionService sessionService;

    /**
     * 登录
     * @param name
     * @param password
     * @param identity
     * @param model
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/login",method = {RequestMethod.POST})
    public String login(String name, String password, String identity, Model model, HttpServletRequest request, HttpServletResponse response) {

        int flag1= 0;
        if (identity.equals("user")) {
            flag1 = userService.findUserByNameAndPwd(name, password);
        } else if (identity.equals("manager")) {
            flag1 = managerService.findManagerByNameAndPwd(name, password);
        } else {
            flag1 = secretaryService.findManagerByNameAndPwd(name, password);
        }
        if (flag1 == 0) {
            model.addAttribute("msg", "*用户名或密码错误*");
            return "login";
        } else if (flag1 == 1) {
            request.getSession().setAttribute("username", name);
            request.getSession().setAttribute("identity",identity);
            if(identity.equals("user")){
                Person person = userService.selectUserByName(name);
                request.getSession().setAttribute("person",person);
                sessionService.changeLogin4Me(person);
                return "user/userframe";
            }else if(identity.equals("manager")){
                Person person = managerService.selectManagerByName(name);
                request.getSession().setAttribute("person",person);
                sessionService.changeLogin4Me(person);
                return "manager/managerframe";
            }else {
                Person person = secretaryService.selectSecretaryByName(name);
                request.getSession().setAttribute("person",person);
                sessionService.changeLogin4Me(person);
                return "secretary/secretaryframe";
            }
        }
        return "login";
    }

    /**
     * 注销登录
     * @param request
     * @param response
     * @param model
     * @param msg
     */
    @RequestMapping("/loginOut")
    public void loginOut(HttpServletRequest request,HttpServletResponse response,Model model,String msg){
        Person person = (Person) request.getSession().getAttribute("person");
        request.getSession().removeAttribute("username");
        request.getSession().removeAttribute("identity");
        request.getSession().removeAttribute("person");
        SessionListener.removeSession(request.getSession().getId());
        SessionListener.removeUserSession(String.valueOf(person.getId()));
        if(msg==null)
            msg="";
        try {
            response.getWriter().write("<script>window.top.location.href=\"/jsp/login.jsp?msg="+msg+"\"</script>");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    @RequestMapping("/toLogin")
    public String toLogin(Model model){
        model.addAttribute("msg","用户已在别处登录，您已被迫下线！");
        return "login";
    }
    @RequestMapping("/noLogin2Login")
    public String noLogin2Login(Model model){
        model.addAttribute("msg","用户未登录！请重新登录");
        return "login";
    }
    /**
     * 登录
     * @param name
     * @param email
     * @param identity
     * @param model
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/retrieve",method = {RequestMethod.POST})
    public String retrieve(String name, String email, String identity, Model model, HttpServletRequest request, HttpServletResponse response) {
        Person person=null;
        if (identity.equals("user")) {
            person = userService.selectUserByName(name);
        } else if (identity.equals("manager")) {
            person= managerService.selectManagerByName(name);
        } else {
            person = secretaryService.selectSecretaryByName(name);
        }
        //是否找到用户
        if(person==null){
            model.addAttribute("msg", "*用户不存在！*");
            return "login";
        }
        //是否输入正确邮箱
        if(!person.getEmail().equals(email)){
            model.addAttribute("msg", "*邮箱错误！*");
            return "login";
        }
        //生成随机密码
        String random_str = UUID.randomUUID().toString().replace("-","").substring(16);
        String random_pwd= MD5Util.generate(random_str);
        person.setPassword(random_pwd);
        //修改密码
        if(identity.equals("user")){
            userService.updateById((User)person);
        }else if(identity.equals("manager")){
            managerService.update((Manager)person);
        }else {
            secretaryService.updateById((Secretary)person);
        }
        //发送邮件
        MailUtil.sendResetPwd(random_str,person.getEmail());
        return "login";
    }
}