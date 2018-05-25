package com.vote.controller;

import com.vote.entity.*;
import com.vote.service.ManagerService;
import com.vote.service.SecretaryService;
import com.vote.service.UserService;
import com.vote.service.VoteProjectService;
import com.vote.util.MD5Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;

/**
 * 个人信息管理Controller
 * Created by sunwe on 2018/3/13.
 */
@Controller
@RequestMapping("/frame")
public class PersonalInfoController {
    @Autowired
    private ManagerService managerService;
    @Autowired
    private SecretaryService secretaryService;
    @Autowired
    private UserService userService;
    @Autowired
    private VoteProjectService voteProjectService;

    /**
     * @param model
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/personalInfoManage")
    public String personalInfoManage(Model model, HttpServletRequest request, HttpServletResponse response) {
        String name = (String) request.getSession().getAttribute("username");
        String identity = (String) request.getSession().getAttribute("identity");
        if (identity.equals("manager")) {
            Manager manager = managerService.selectManagerByName(name);
            model.addAttribute("person", manager);
        } else if (identity.equals("secretary")) {
            Secretary secretary = secretaryService.selectSecretaryByName(name);
            model.addAttribute("person", secretary);
        } else {
            User user = userService.selectUserByName(name);
            model.addAttribute("person", user);
        }
        return "frame/personinfomanage";
    }

    /**
     * 页面跳转
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping("/toChangePwd")
    public String toChangePwd(HttpServletRequest request, HttpServletResponse response, Model model) {
        return "frame/changepassword";
    }

    /**
     * 修改密码
     * @param response
     * @param request
     * @param model
     * @param passwordVo
     * @return
     */
    @RequestMapping(value = "/changePwd",method = {RequestMethod.POST})
    public String changePwd(HttpServletResponse response, HttpServletRequest request, Model model, PasswordVo passwordVo) throws UnsupportedEncodingException {
        String name = (String) request.getSession().getAttribute("username");
        String identity = (String) request.getSession().getAttribute("identity");
        String oldPwd = passwordVo.getOldPassword();
        String newPwd = passwordVo.getNewPassword();
        if (identity.equals("manager")) {
            Manager manager =  managerService.selectManagerByName(name);
            if (!MD5Util.verify(oldPwd,manager.getPassword())) {
                model.addAttribute("msg", "旧密码错误,请重新输入");
                return "frame/changepassword";
            } else {
                String md5 = MD5Util.generate(newPwd);
                manager.setPassword(md5);
                managerService.update(manager);
            }
        } else if (identity.equals("secretary")) {
            Secretary secretary = secretaryService.selectSecretaryByName(name);
            if (!MD5Util.verify(oldPwd,secretary.getPassword())) {
                model.addAttribute("msg", "旧密码错误,请重新输入");
                return "frame/changepassword";
            } else {
                String md5 = MD5Util.generate(newPwd);
                secretary.setPassword(md5);
                secretaryService.updateById(secretary);
            }
        } else {
            User user = userService.selectUserByName(name);
            if (!MD5Util.verify(oldPwd,user.getPassword())) {
                model.addAttribute("msg", "旧密码错误,请重新输入");
                return "frame/changepassword";
            } else {
                String md5 = MD5Util.generate(newPwd);
                user.setPassword(md5);
                userService.updateById(user);
            }
        }
        return "redirect:/user/loginOut?msg="+ URLEncoder.encode("密码已修改，请重新登录","utf-8");
    }

    /**
     * 修改个人信息
     * @param request
     * @param response
     * @param model
     * @param person
     * @return
     */
    @RequestMapping(value = "/personalInfoChange",method = {RequestMethod.POST,RequestMethod.GET})
    public  String personalInfoChange(HttpServletRequest request, HttpServletResponse response, Model model, Person person){
          String identity = (String) request.getSession().getAttribute("identity");
          if(identity.equals("manager")){
              Manager manager = new Manager();
              manager.setId(person.getId());
              manager.setName(person.getName());
              //manager.setPassword(person.getPassword());
              manager.setTel(person.getTel());
              manager.setEmail(person.getEmail());
              managerService.update(manager);
          }else if(identity.equals("user")){
              User user = new User();
              user.setId(person.getId());
              //user.setPassword(person.getPassword());
              user.setName(person.getName());
              user.setEmail(person.getEmail());
              user.setTel(person.getTel());
              userService.updateById(user);
        }else {
              Secretary secretary = new Secretary();
              secretary.setId(person.getId());
              //secretary.setPassword(person.getPassword());
              secretary.setEmail(person.getEmail());
              secretary.setName(person.getName());
              secretary.setTel(person.getTel());
              secretaryService.updateById(secretary);
          }
          return "frame/changesuccess";
    }
    @RequestMapping("/toMain")
    public String toMain(Model model){
        List<VoteProject> list = voteProjectService.selectByIsClose(true);
        int singleSum = 0;
        int multiSum = 0;
        for (VoteProject vo:list) {
            if(vo.isVoteMode()==false){
                singleSum++;
            }else if(vo.isVoteMode()==true){
                multiSum++;
            }
        }
        model.addAttribute("sum",list.size());
        model.addAttribute("singleSum",singleSum);
        model.addAttribute("multiSum",multiSum);
        return "frame/main";
    }
    @RequestMapping("/toError")
    public String toError(Model model){
        return "roleserror";
    }
    @RequestMapping("/passwordEncrypt")
    public void passwordEncrypt(Model model){
        List<Manager> managers = managerService.selectManager();
        List<User> users = userService.findAllUser();
        List<Secretary> secretaries = secretaryService.selectSecretary();
        for(Manager manager:managers){
            manager.setPassword(MD5Util.generate(manager.getPassword()));
            managerService.update(manager);
        }
        for(Secretary secretary:secretaries){
            secretary.setPassword(MD5Util.generate(secretary.getPassword()));
            secretaryService.updateById(secretary);
        }
        for(User user:users){
            user.setPassword(MD5Util.generate(user.getPassword()));
            userService.updateById(user);
        }
    }
}
