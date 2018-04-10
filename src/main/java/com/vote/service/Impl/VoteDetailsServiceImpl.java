package com.vote.service.Impl;

import com.vote.dao.VoteDetailsDao;
import com.vote.entity.VoteDetails;
import com.vote.service.VoteDetailsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 投票信息统计实现类
 * Created by sunwe on 2018/3/7.
 */
@Service
public class VoteDetailsServiceImpl implements VoteDetailsService {

    @Autowired
    private VoteDetailsDao voteDetailsDao;

    @Transactional
    public int deleteByPrimaryKey(Long id) {
        return voteDetailsDao.deleteByPrimaryKey(id);
    }

    @Transactional
    public int insert(VoteDetails record) {
        return voteDetailsDao.insertSelective(record);
    }

    @Transactional
    public VoteDetails selectByPrimaryKey(Long id) {
        return voteDetailsDao.selectByPrimaryKey(id);
    }

    @Transactional
    public int updateByPrimaryKey(VoteDetails record) {
        return voteDetailsDao.updateByPrimaryKeySelective(record);
    }

    @Override
    @Transactional
    public VoteDetails selectByProjectIdAndVoter(long id, String name) {
        return voteDetailsDao.selectByProjectIdAndVoter(id,name);
    }

    @Override
    @Transactional
    public int deleteByProjectId(Long id) {
        return voteDetailsDao.deleteByProjectId(id);
    }

    @Override
    @Transactional
    public List<VoteDetails> selectByVoter(String name) {
        return voteDetailsDao.selectByVoter(name);
    }

}
