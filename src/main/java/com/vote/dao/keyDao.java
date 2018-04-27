package com.vote.dao;

import com.vote.entity.key;
import org.springframework.stereotype.Repository;

@Repository
public interface keyDao {
    int deleteByPrimaryKey(Long id);

    int insert(key record);

    int insertSelective(key record);

    key selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(key record);

    int updateByPrimaryKey(key record);
}