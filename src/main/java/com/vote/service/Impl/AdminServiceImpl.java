package com.vote.service.Impl;

import com.vote.dao.AdminDao;
import com.vote.entity.Admin;
import com.vote.service.AdminService;
import com.vote.util.MD5Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by wh on 2018/6/7.
 */
@Service
public class AdminServiceImpl implements AdminService{
   @Autowired
   AdminDao adminDao;
    @Override
    public boolean login(String name, String password) {
        Admin admin=adminDao.selectAdminByName(name);
        if(admin!=null){
            String pwd=admin.getPassword();
            if(MD5Util.verify(password,pwd)){
                return true;
            }
        }
        return false;
    }

    @Override
    public Admin selectAdminByName(String name) {
        return adminDao.selectAdminByName(name);
    }
}
