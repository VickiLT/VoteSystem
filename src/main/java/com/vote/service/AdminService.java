package com.vote.service;

import com.vote.entity.Admin;

/**
 * Created by wh on 2018/6/7.
 */
public interface AdminService {

    boolean  login(String name,String pwd);
    Admin selectAdminByName(String name);
}
