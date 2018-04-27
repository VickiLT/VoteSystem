package com.vote.service.Impl;

import com.vote.dao.RoleDao;
import com.vote.entity.Role;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.stereotype.Service;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;

import javax.servlet.ServletContext;
import java.util.*;

/**
 * Created by sunwe on 2018/4/10.
 */
@Service
public class StartupListener implements ApplicationListener<ContextRefreshedEvent> {
    @Autowired
    private RoleDao roleDao;
    @Autowired
    private ServletContext servletContext;

    @Override
    public void onApplicationEvent(ContextRefreshedEvent contextRefreshedEvent) {
//        WebApplicationContext webApplicationContext = ContextLoader.getCurrentWebApplicationContext();
//        ServletContext servletContext = webApplicationContext.getServletContext();
        List<Role> allRoles = roleDao.getAllRoles();
        Map<String, Set<String>> resourceMap = new HashMap<String, Set<String>>();
        for (Role role : allRoles) {
            Set<String> atts = new HashSet<String>();
            String permission = role.getPermission();
            String[] per = permission.split("");
            for (int i = 0; i < per.length; i++) {
                atts.add(per[i]);
            }
            resourceMap.put(role.getResource(),atts);
        }
        servletContext.setAttribute("resourceMap",resourceMap);
    }
}
