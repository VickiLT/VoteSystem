package com.vote.service.Impl;

import com.vote.dao.SecretaryDao;
import com.vote.entity.Secretary;
import com.vote.service.SecretaryService;
import com.vote.util.MD5Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by sunwe on 2018/3/13.
 */
@Service
public class SecretaryServiceImpl implements SecretaryService {
    @Autowired
    private SecretaryDao secretaryDao;

    @Override
    @Transactional
    public int insert(Secretary record) {
        return secretaryDao.insert(record);
    }
    @Override
    @Transactional
    public Secretary selectById(Integer id) {
        return null;
    }

    @Override
    @Transactional
    public int updateById(Secretary record) {
        return secretaryDao.updateByPrimaryKeySelective(record);
    }

    @Override
    @Transactional
    public int deleteById(Integer id) {
        return secretaryDao.deleteByPrimaryKey(id);
    }

    @Override
    @Transactional
    public int findManagerByNameAndPwd(String name, String password) {
        Secretary secretary = selectSecretaryByName(name);
        if (secretary != null) {
            String pwd = secretary.getPassword();
            if (MD5Util.verify(password,pwd)) {
                return 1;
            }
        }
        return 0;
    }

    @Transactional
    public List<Secretary> findSecretaryByName(String name) {

        return secretaryDao.findSecretaryByName(name);
    }

    @Override
    public List<Secretary> selectSecretary() {
        return secretaryDao.selectSecretary();
    }

    @Override
    public Secretary selectSecretaryByName(String name) {
        return secretaryDao.selectSecretaryByName(name);
    }

    @Override
    public int activeAccount(String code) {

        return secretaryDao.updateByCode(code);
    }
}
