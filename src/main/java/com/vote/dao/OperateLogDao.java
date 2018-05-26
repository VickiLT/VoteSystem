package com.vote.dao;

import com.vote.entity.operateLog;
import org.springframework.stereotype.Repository;

@Repository
public interface OperateLogDao {
    int deleteByPrimaryKey(Long id);

    int insert(operateLog record);

    int insertSelective(operateLog record);

    operateLog selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(operateLog record);

    int updateByPrimaryKey(operateLog record);
}