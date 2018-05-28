package com.vote.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.vote.entity.User;
import com.vote.entity.VoteProject;
import com.vote.service.UserService;
import com.vote.util.MD5Util;
import com.vote.util.MailUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.jws.soap.SOAPBinding;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

/**
 * Created by sunwe on 2018/3/21.
 */
@RequestMapping("/manage/userManage")
@Controller
public class UserManageController {

    @Autowired
    private UserService userService;

    /**
     * 加载用户
     * @param page
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/load")
    @ResponseBody
    public PageInfo<User> load(@RequestParam(required = true, defaultValue = "1") Integer page, HttpServletRequest request, Model model){
        PageHelper.startPage(page, 10);
        List<User> list = userService.findAllUser();
        PageInfo<User> p = new PageInfo<User>(list);
        p.setList(list);
        return p;
    }

    @RequestMapping(value = "/search")
    @ResponseBody
    public PageInfo<User> search(@RequestParam(required = true, defaultValue = "1") Integer page, HttpServletRequest request, Model model, String name){
        PageHelper.startPage(page, 10);
        List<User> list = userService.findUserByName(name);
        PageInfo<User> p = new PageInfo<User>(list);
        p.setList(list);
        return p;
    }

    @RequestMapping(value = "/delete")
    @ResponseBody
    public String delete(HttpServletRequest request){
        int id = Integer.parseInt(request.getParameter("id"));
        userService.deleteById(id);
        return request.getParameter("id");
    }
    @RequestMapping(value = "/addConsoleDlg")
    public String addConsoleDlg(Model model){
        return "manager/usermanageconsoleDlg";
    }

    @RequestMapping(value = "/createUser")
    @ResponseBody
    public Map<String, Object> createUser(User user){
        Map<String,Object> map = new HashMap<String,Object>();
        int i = 0;
        if(user.getName()!=null && !(user.getName().equals(""))){
            if(user.getPassword()!=null && !(user.getPassword().equals(""))){
                 User user1 = userService.selectUserByName(user.getName());
                 if(user1!=null){
                     map.put("user",null);
                     map.put("message","用户名已存在");
                     return map;
                 }else {
                     user.setPassword(MD5Util.generate(user.getPassword()));
                     user.setStatus(0);
                     user.setIdentity("2");
                     user.setCode(UUID.randomUUID().toString().replace("-",""));
                     i = userService.insert(user);
                     MailUtil.sendRegisterCode(user.getCode(),user.getIdentity(),user.getEmail());
                 }
            }
        }
        if(i==0)
            return null;
        else{
            map.put("message",null);
            map.put("user",user);
            return map;
        }
    }

    @RequestMapping("/updateUser")
    @ResponseBody
    public User updateUser(User user){
        int i = 0;
        if(user.getName()!=null && !(user.getName().equals(""))){
            if(user.getPassword()!=null && !(user.getPassword().equals(""))){
                user.setPassword(MD5Util.generate(user.getPassword()));
                user.setId(Integer.parseInt(user.getIds()));
                i = userService.updateById(user);
            }
        }
        if(i==0)
            return null;
        else
            return user;
    }
}
