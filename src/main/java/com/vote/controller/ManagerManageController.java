package com.vote.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.vote.entity.Manager;
import com.vote.entity.Secretary;
import com.vote.service.ManagerService;
import com.vote.service.SecretaryService;
import com.vote.util.MD5Util;
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

/**
 * Created by sunwe on 2018/3/23.
 */
@Controller
@RequestMapping("/manage/managerManage")
public class ManagerManageController {
    @Autowired
    private ManagerService managerService;

    /**
     * 加载
     * @param page
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/load", method = {RequestMethod.POST})
    @ResponseBody
    public PageInfo<Manager> load(@RequestParam(required = true, defaultValue = "1") Integer page, HttpServletRequest request, Model model) {
        PageHelper.startPage(page, 10);
        List<Manager> list = managerService.selectManager();
        PageInfo<Manager> p = new PageInfo<Manager>(list);
        p.setList(list);
        return p;
    }

    /**
     * 查询
     * @param page
     * @param request
     * @param model
     * @param name
     * @return
     */
    @RequestMapping(value = "/search")
    @ResponseBody
    public PageInfo<Manager> search(@RequestParam(required = true, defaultValue = "1") Integer page, HttpServletRequest request, Model model, String name) {
        PageHelper.startPage(page, 10);
        List<Manager> list = managerService.findManagerByName(name);
        PageInfo<Manager> p = new PageInfo<Manager>(list);
        p.setList(list);
        return p;
    }

    /**
     * 查询
     * @param request
     * @return
     */
    @RequestMapping(value = "/delete")
    @ResponseBody
    public String delete(HttpServletRequest request) {
        int id = Integer.parseInt(request.getParameter("id"));
        managerService.deleteById(id);
        return request.getParameter("id");
    }

    @RequestMapping(value = "/addConsoleDlg")
    public String addConsoleDlg(Model model) {
        return "manager/usermanageconsoleDlg";
    }

    /**
     * 创建管理员
     * @param manager
     * @return
     */
    @RequestMapping(value = "/createManager")
    @ResponseBody
    public Map<String, Object> createManager(Manager manager) {
        Map<String, Object> map = new HashMap<String, Object>();
        int i = 0;
        if (manager.getName() != null && !(manager.getName().equals(""))) {
            if (manager.getPassword() != null && !(manager.getPassword().equals(""))) {
                Manager manager1 = managerService.selectManagerByName(manager.getName());
                if (manager1 != null) {
                    map.put("manager", null);
                    map.put("message", "用户名已存在");
                    return map;
                } else {
                    manager.setPassword(MD5Util.generate(manager.getPassword()));
                    i = managerService.insert(manager);
                }
            }
        }
        if (i == 0)
            return null;
        else {
            map.put("message", null);
            map.put("manager", manager);
            return map;
        }
    }

    /**
     * 更新管理员
     * @param manager
     * @return
     */
    @RequestMapping("/updateManager")
    @ResponseBody
    public Manager updateManager(Manager manager) {
        int i = 0;
        if (manager.getName() != null && !(manager.getName().equals(""))) {
            if (manager.getPassword() != null && !(manager.getPassword().equals(""))) {
                manager.setPassword(MD5Util.generate(manager.getPassword()));
                manager.setId(Integer.parseInt(manager.getIds()));
                i = managerService.update(manager);
            }
        }
        if (i == 0)
            return null;
        else
            return manager;
    }
}
