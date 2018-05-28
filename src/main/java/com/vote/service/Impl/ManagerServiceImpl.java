package com.vote.service.Impl;

import com.vote.dao.ManagerDao;
import com.vote.dao.UserDao;
import com.vote.entity.Manager;
import com.vote.entity.User;
import com.vote.service.ManagerService;
import com.vote.service.UserService;
import com.vote.util.MD5Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 管理员service实现类
 * Created by sunwe on 2018/3/7.
 */
@Service
public class ManagerServiceImpl implements ManagerService {

    @Autowired
    private ManagerDao managerDao;
    @Autowired
    private UserService userService;

    @Transactional
    public int insert(Manager record) {
        return managerDao.insertSelective(record);
    }

    @Transactional
    public Manager selectById(Integer id) {
        return managerDao.selectByPrimaryKey(id);
    }

    @Transactional
    public int deleteById(Integer id) {
        return managerDao.deleteByPrimaryKey(id);
    }

    @Transactional
    public int update(Manager record) {
        return managerDao.updateByPrimaryKeySelective(record);
    }

    @Transactional
    public int createUser(User record) {
        return userService.insert(record);
    }

    @Transactional
    public int deleteUser(Integer id) {
        return userService.deleteById(id);
    }

    @Transactional
    public int findManagerByNameAndPwd(String name, String password) {
        Manager manager = selectManagerByName(name);
        if (manager != null) {
            String pwd = manager.getPassword();
            if (MD5Util.verify(password,pwd)) {
                return 1;
            }
        }
        return 0;
    }

    @Transactional
    public List<Manager> findManagerByName(String name) {
        return managerDao.findManagerByName(name);
    }

    @Transactional
    @Override
    public List<Manager> selectManager() {
        return managerDao.selectManager();
    }

    @Transactional
    @Override
    public Manager selectManagerByName(String name) {
        return managerDao.selectManagerByName(name);
    }

    @Override
    public int activeAccount(String code) {
        return managerDao.updateByCode(code);

    }
}
