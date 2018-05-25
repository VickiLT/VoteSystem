package com.vote.service.Impl;

import com.vote.dao.KeyDao;
import com.vote.entity.Key;
import com.vote.service.KeyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Created by sunwe on 2018/5/16.
 */
@Service
public class KeyServiceImpl implements KeyService {

    @Autowired
    private KeyDao keyDao;

    @Override
    @Transactional
    public int deleteByPrimaryKey(Long id) {
        return 0;
    }

    @Override
    @Transactional
    public int insert(Key record) {
        return keyDao.insert(record);
    }

    @Override
    @Transactional
    public int insertSelective(Key record) {
        return keyDao.insertSelective(record);
    }

    @Override
    @Transactional
    public Key selectByPrimaryKey(Long id) {
        return null;
    }

    @Override
    @Transactional
    public int updateByPrimaryKeySelective(Key record) {

        return keyDao.updateByPrimaryKeySelective(record);
    }

    @Override
    @Transactional
    public int updateByPrimaryKey(Key record) {
        return 0;
    }

    @Override
    @Transactional
    public Key selectByVoteId(Long voteDetailsId) {
        return keyDao.selectByVoteId(voteDetailsId);
    }
}
