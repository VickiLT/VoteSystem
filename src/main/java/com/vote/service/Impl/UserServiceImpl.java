package com.vote.service.Impl;

import com.vote.dao.UserDao;
import com.vote.entity.User;
import com.vote.service.UserService;
import com.vote.util.MD5Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 用户管理实现类
 * Created by sunwe on 2018/3/7.
 */
@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDao userDao;

    @Transactional
    public int insert(User record) {
        return userDao.insertSelective(record);
    }

    @Transactional
    public User selectById(Integer id) {
        return userDao.selectByPrimaryKey(id);
    }

    @Transactional
    public int updateById(User record) {
        return userDao.updateByPrimaryKeySelective(record);
    }

    @Transactional
    public int deleteById(Integer id) {
        return userDao.deleteByPrimaryKey(id);
    }

    /**
     * 通过用户名和密码查找用户
     *
     * @param name
     * @param password
     * @return
     */
    @Transactional
    public int findUserByNameAndPwd(String name, String password) {
        User user = selectUserByName(name);
        if (user != null) {
            String pwd = user.getPassword();
            if (MD5Util.verify(password,pwd)) {
                return 1;
            }
        }
        return 0;
    }

    @Transactional
    public List<User> findUserByName(String name) {

        return userDao.findUserByName(name);
    }

    @Override
    public List<User> findAllUser() {
        return userDao.findAllUser();
    }

    @Override
    public User selectUserByName(String name) {
        return userDao.selectUserByName(name);
    }

    @Override
    public int activeAccount(String code) {
        return userDao.updateByCode(code);
    }

    @Override
    public User selectUserByCode(String code) {
        return userDao.selectUserByCode(code);
    }
}
