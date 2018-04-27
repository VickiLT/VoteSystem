package com.vote.service.Impl;

import com.vote.dao.RoleDao;
import com.vote.entity.Role;
import com.vote.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by sunwe on 2018/4/10.
 */
@Service
public class RoleServiceImpl implements RoleService {
    @Autowired
    private RoleDao roleDao;
    @Override
    @Transactional
    public Role selectByResource(String url) {
        return roleDao.selectByResource(url);
    }

    @Override
    @Transactional
    public List<Role> getAllRoles() {
        return roleDao.getAllRoles();
    }


}
