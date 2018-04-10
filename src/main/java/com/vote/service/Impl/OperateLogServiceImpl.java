package com.vote.service.Impl;

import com.vote.dao.OperateLogDao;
import com.vote.entity.operateLog;
import com.vote.service.OperateLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by sunwe on 2018/3/31.
 */
@Service
public class OperateLogServiceImpl implements OperateLogService {
    @Autowired
    private OperateLogDao operateLogDao;
    @Override
    public int deleteByPrimaryKey(Long id) {
        return operateLogDao.deleteByPrimaryKey(id);
    }

    @Override
    public int insert(operateLog record) {
        return operateLogDao.insert(record);
    }

    @Override
    public int insertSelective(operateLog record) {
        return operateLogDao.insertSelective(record);
    }

    @Override
    public operateLog selectByPrimaryKey(Long id) {
        return operateLogDao.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(operateLog record) {
        return operateLogDao.updateByPrimaryKeySelective(record);
    }

    @Override
    public int updateByPrimaryKey(operateLog record) {
        return operateLogDao.updateByPrimaryKey(record);
    }
}
