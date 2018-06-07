package com.vote.service;

import com.vote.entity.Admin;

/**
 * Created by wh on 2018/6/7.
 */
public interface AdminService {

    boolean  login(String name,String pwd);
    int update(Admin record);
    Admin selectAdminByName(String name);
    Admin selectAdminByCode(String code);
}
