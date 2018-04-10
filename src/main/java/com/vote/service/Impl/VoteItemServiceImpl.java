package com.vote.service.Impl;

import com.vote.dao.VoteItemDao;
import com.vote.entity.VoteItem;
import com.vote.service.VoteItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 投票选项管理实现类
 * Created by sunwe on 2018/3/7.
 */
@Service
public class VoteItemServiceImpl implements VoteItemService {

    @Autowired
    private VoteItemDao voteItemDao;

    @Transactional
    public int deleteById(long id) {
        return voteItemDao.deleteByPrimaryKey(id);
    }

    @Transactional
    public int insert(VoteItem record) {
        return voteItemDao.insert(record);
    }

    @Transactional
    public VoteItem selectById(Integer id) {
        return voteItemDao.selectByPrimaryKey(id);
    }

    @Transactional
    public int update(VoteItem record) {
        return voteItemDao.updateByPrimaryKeySelective(record);
    }

    @Override
    @Transactional
    public List<VoteItem> selectByVoteProjectId(long id) {
       return voteItemDao.selectByVoteProjectId(id);
    }

    @Override
    @Transactional
    public VoteItem selectByProjectIdAndNumber(long id, String number) {
        return voteItemDao.selectByProjectIdAndNumber(id,number);
    }

    @Override
    @Transactional
    public int deleteByProjectId(long id) {
        return voteItemDao.deleteByProjectId(id);
    }
}
