package com.vote.service;

import com.vote.entity.User;

import java.util.List;

/**
 * 用户管理service
 * Created by sunwe on 2018/3/7.
 */
public interface UserService {

    int insert(User record);

    User selectById(Integer id);

    int updateById(User record);

    int deleteById(Integer id);

    int findUserByNameAndPwd(String name, String password);

    List<User> findUserByName(String name);

    List<User> findAllUser();

    User selectUserByName(String name);
    User selectUserByCode(String code);
    int activeAccount(String code);

}
