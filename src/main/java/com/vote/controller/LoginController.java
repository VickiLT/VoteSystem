package com.vote.controller;

import com.vote.entity.*;
import com.vote.service.*;
import com.vote.entity.User;
import com.vote.service.Impl.KeyServiceImpl;
import com.vote.util.MD5Util;
import com.vote.util.MailUtil;
import com.vote.util.SessionListener;
import common.CommonResult;
import org.aspectj.apache.bcel.verifier.VerifierFactoryObserver;
import org.aspectj.weaver.patterns.PerObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RequestBody;
import javax.rmi.CORBA.Util;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
            if(identity.equals("user")){
                Person person = userService.selectUserByName(name);
                request.getSession().setAttribute("username", name);
                request.getSession().setAttribute("identity",identity);
                if(person.getStatus()==0){
                    model.addAttribute("msg", "*用户未激活*");
                    model.addAttribute("status", "0");
                    return "login";
                }else if(person.getStatus()==1){
                    model.addAttribute("msg", "请设置你的密码");
                    model.addAttribute("username", person.getName());
                    model.addAttribute("identity", identity);
                    model.addAttribute("code", person.getCode());
                    model.addAttribute("errno","0");
                    return "activeSuccess";
                }

                request.getSession().setAttribute("person",person);
                sessionService.changeLogin4Me(person);
                return "user/userframe";
            }else if(identity.equals("manager")){
                Person person = managerService.selectManagerByName(name);
                request.getSession().setAttribute("username", name);
                request.getSession().setAttribute("identity",identity);
                if(person.getStatus()==0){
                    model.addAttribute("msg", "*用户未激活*");
                    model.addAttribute("status", "0");
                    return "login";
                }else if(person.getStatus()==1){
                    model.addAttribute("msg", "请设置你的密码");
                    model.addAttribute("username", person.getName());
                    model.addAttribute("identity", identity);
                    model.addAttribute("code", person.getCode());
                    model.addAttribute("errno","0");
                    return "activeSuccess";
                }

                request.getSession().setAttribute("person",person);
                sessionService.changeLogin4Me(person);
                return "manager/managerframe";
            }else {
                Person person = secretaryService.selectSecretaryByName(name);
                request.getSession().setAttribute("username", name);
                request.getSession().setAttribute("identity",identity);
                if(person.getStatus()==0){
                    model.addAttribute("msg", "*用户未激活*");
                    model.addAttribute("status", "0");
                    return "login";
                }else if(person.getStatus()==1){
                    model.addAttribute("msg", "请设置你的密码");
                    model.addAttribute("username", person.getName());
                    model.addAttribute("identity", identity);
                    model.addAttribute("code", person.getCode());
                    model.addAttribute("errno","0");
                    return "activeSuccess";
                }

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
     *
     *
     */
    @RequestMapping(value = "/retrieve",method = {RequestMethod.POST})
    @ResponseBody
    public Map<String, Object> retrieve(@RequestBody User user) {
        Person person=null;
        String name=user.getName();
        String email=user.getEmail();
        String identity=user.getIdentity();
        Map<String,Object> map = new HashMap<String,Object>();
        String status="1";
        if (identity.equals("user")) {
            person = userService.selectUserByName(name);
        } else if (identity.equals("manager")) {
            person= managerService.selectManagerByName(name);
        } else {
            person = secretaryService.selectSecretaryByName(name);
        }
        //是否找到用户
        if(person==null){
            map.put("message","用户不存在");
            map.put("status","0");
            return map;
        }
        //是否输入正确邮箱
        if(!person.getEmail().equals(user.getEmail())){
            map.put("message","邮箱错误");
            map.put("status","0");
            return map;
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
        map.put("message","重置成功，请到邮箱查看新密码");
        map.put("status","1");
        return map;
    }

    @RequestMapping("/activeAccount")
    public String activeAccount(Model model,HttpServletRequest request) {
        String code = request.getParameter("code");
        String identity=request.getParameter("identity");
        Person person=null;
        if(identity.equals("manager")){
            person=managerService.selectManagerByCode(code);
            if(person!=null) managerService.activeAccount(code);
        }else
        if(identity.equals("user")){
            person=userService.selectUserByCode(code);
            if(person!=null) userService.activeAccount(code);
        }else{
            person=secretaryService.selectSecretaryByCode(code);
            if(person!=null) secretaryService.activeAccount(code);
        }
        if(person!=null) {
            model.addAttribute("msg", "请设置你的密码");
            model.addAttribute("username", person.getName());
            model.addAttribute("identity", identity);
            model.addAttribute("code", code);
            model.addAttribute("errno","0");
        }else
        {
            model.addAttribute("msg", "系统错误");
            model.addAttribute("errno","1");
        }
        return "activeSuccess";
    }

    @RequestMapping("/sentActiveMail")
    @ResponseBody
    public CommonResult<String> sentActiveMail(@RequestBody User user,Model model, HttpServletRequest request) {
        if(user==null)
            return new CommonResult<String>("1");
        String identity=user.getIdentity();
        String name=user.getName();
        Person person=null;
        if(identity.equals("manager")){
            person=managerService.selectManagerByName(name);
        }else if(identity.equals("user")){
            person=userService.selectUserByName(name);
        }else {
            person=secretaryService.selectSecretaryByName(name);
        }
        if(person!=null) {
            MailUtil.sendRegisterCode(person.getCode(),identity,person.getEmail());
            return new CommonResult<String>("0");
        }
        return new CommonResult<String>("1");
    }

    @RequestMapping("/firstLogin")
    public String firstLogin(Model model, HttpServletRequest request) {
        String name= request.getParameter("username");
        String pwd= request.getParameter("newPassword");
        String code = request.getParameter("code");
        String identity=request.getParameter("identity");
        Person person=null;
        if(identity.equals("manager")){
            person=managerService.selectManagerByName(name);
        }else
        if(identity.equals("user")){
            person=userService.selectUserByName(name);
        }else{
            person=secretaryService.selectSecretaryByName(name);
        }
        if(person==null||!person.getCode().equals(code)){
            model.addAttribute("msg","初始化密码出错，请联系管理员");
            return "login";
        }
        person.setPassword(MD5Util.generate(pwd));

        person.setStatus(2);
        if(identity.equals("user")){
            userService.updateById((User)person);
        }else if(identity.equals("manager")){
            managerService.update((Manager)person);
        }else {
            secretaryService.updateById((Secretary)person);
        }

        return "login";
    }
}