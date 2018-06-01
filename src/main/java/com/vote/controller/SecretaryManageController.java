package com.vote.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.vote.entity.Manager;
import com.vote.entity.Secretary;
import com.vote.entity.User;
import com.vote.service.ManagerService;
import com.vote.service.SecretaryService;
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

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

/**
 * Created by sunwe on 2018/3/23.
 */
@RequestMapping("/manage/secretaryManage")
@Controller
public class SecretaryManageController {

    @Autowired
    private ManagerService managerService;

    @Autowired
    private UserService userService;
    @Autowired
    private SecretaryService secretaryService;

    @RequestMapping(value = "/load", method = {RequestMethod.POST})
    @ResponseBody
    public PageInfo<Secretary> load(@RequestParam(required = true, defaultValue = "1") Integer page, HttpServletRequest request, Model model) {
        PageHelper.startPage(page, 8);
        List<Secretary> list = secretaryService.selectSecretary();
        PageInfo<Secretary> p = new PageInfo<Secretary>(list);
        p.setList(list);
        return p;
    }

    @RequestMapping(value = "/search")
    @ResponseBody
    public PageInfo<Secretary> search(@RequestParam(required = true, defaultValue = "1") Integer page, HttpServletRequest request, Model model, String name) {
        PageHelper.startPage(page, 10);
        List<Secretary> list = secretaryService.findSecretaryByName(name);
        PageInfo<Secretary> p = new PageInfo<Secretary>(list);
        p.setList(list);
        return p;
    }

    @RequestMapping(value = "/delete")
    @ResponseBody
    public String delete(HttpServletRequest request) {
        int id = Integer.parseInt(request.getParameter("id"));
        secretaryService.deleteById(id);
        return request.getParameter("id");
    }

    @RequestMapping(value = "/addConsoleDlg")
    public String addConsoleDlg(Model model) {
        return "manager/usermanageconsoleDlg";
    }

    @RequestMapping(value = "/createSecretary")
    @ResponseBody
    public Map<String, Object> createSecretary(Secretary secretary) {
        Map<String, Object> map = new HashMap<String, Object>();
        int i = 0;
        if (secretary.getName() != null && !(secretary.getName().equals(""))) {
            if (secretary.getPassword() != null && !(secretary.getPassword().equals(""))) {
                Manager manager=managerService.selectManagerByName(secretary.getName());
                User user=userService.selectUserByName(secretary.getName());
                Secretary secretary1 = secretaryService.selectSecretaryByName(secretary.getName());
                if (manager!=null||user!=null||secretary1 != null) {
                    map.put("secretary", null);
                    map.put("message", "用户名已存在");
                    return map;
                } else {
                    secretary.setPassword(MD5Util.generate(secretary.getPassword()));
                    secretary.setStatus(0);
                    secretary.setIdentity("3");
                    secretary.setCode(UUID.randomUUID().toString().replace("-",""));
                    i = secretaryService.insert(secretary);
                }
            }
        }
        if (i == 0)
            return null;
        else {
            map.put("message", null);
            map.put("secretary", secretary);
            return map;
        }
    }

    @RequestMapping("/updateSecretary")
    @ResponseBody
    public Secretary updateSecretary(Secretary secretary) {
        int i = 0;
        if (secretary.getName() != null && !(secretary.getName().equals(""))) {
            if (secretary.getPassword() != null && !(secretary.getPassword().equals(""))) {
                secretary.setId(Integer.parseInt(secretary.getIds()));
                secretary.setPassword(MD5Util.generate(secretary.getPassword()));
                i = secretaryService.updateById(secretary);
            }
        }
        if (i == 0)
            return null;
        else
            return secretary;
    }
}
