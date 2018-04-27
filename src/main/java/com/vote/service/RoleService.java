package com.vote.service;

import com.vote.entity.Role;

import java.util.List;

/**
 * Created by sunwe on 2018/4/10.
 */
public interface RoleService {
    Role selectByResource(String url);
    List<Role> getAllRoles();
}
