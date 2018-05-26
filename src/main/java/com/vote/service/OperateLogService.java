package com.vote.service;

import com.vote.entity.operateLog;

/**
 * Created by sunwe on 2018/3/31.
 */
public interface OperateLogService {
    int deleteByPrimaryKey(Long id);

    int insert(operateLog record);

    int insertSelective(operateLog record);

    operateLog selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(operateLog record);

    int updateByPrimaryKey(operateLog record);
}
