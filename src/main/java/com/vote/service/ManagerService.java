package com.vote.service;

import com.vote.entity.Manager;
import com.vote.entity.User;

import java.util.List;

/**
 * 管理员service
 * Created by sunwe on 2018/3/7.
 */
public interface ManagerService {

    int insert(Manager record);

    Manager selectById(Integer id);

    int deleteById(Integer id);

    int update(Manager record);

    int createUser(User record);

    int deleteUser(Integer id);

    int findManagerByNameAndPwd(String name, String password);

    List<Manager> findManagerByName(String name);

    List<Manager> selectManager();

    Manager selectManagerByName(String name);
}
