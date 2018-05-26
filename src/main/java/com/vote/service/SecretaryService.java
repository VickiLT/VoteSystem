package com.vote.service;

import com.vote.entity.Secretary;

import java.util.List;

/**
 * Created by sunwe on 2018/3/13.
 */
public interface SecretaryService {
    int insert(Secretary record);
    Secretary selectById(Integer id);
    int updateById(Secretary record);
    int deleteById(Integer id);
    int findManagerByNameAndPwd(String name,String password);
    List<Secretary> findSecretaryByName(String name);
    List<Secretary> selectSecretary();
    Secretary selectSecretaryByName(String name);
}
