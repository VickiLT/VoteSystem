package com.vote.dao;

import com.vote.entity.Secretary;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SecretaryDao {
    int deleteByPrimaryKey(Integer id);

    int insert(Secretary record);

    int insertSelective(Secretary record);

    Secretary selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Secretary record);

    int updateByPrimaryKey(Secretary record);

    List<Secretary> findSecretaryByName(String name);

    List<Secretary> selectSecretary();

    Secretary selectSecretaryByName(String name);

    int updateByCode(String code);
}