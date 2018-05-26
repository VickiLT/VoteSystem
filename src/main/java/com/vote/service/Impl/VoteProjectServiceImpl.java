package com.vote.service.Impl;

import com.vote.dao.VoteProjectDao;
import com.vote.entity.VoteProject;
import com.vote.service.VoteProjectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;

/**
 * 投票项目管理实现类
 * Created by sunwe on 2018/3/7.
 */
@Service
public class VoteProjectServiceImpl implements VoteProjectService {

    @Autowired
    private VoteProjectDao voteProjectDao;

    @Transactional
    public int deleteById(Long id) {
        return voteProjectDao.deleteByPrimaryKey(id);
    }

    @Transactional
    public int insert(VoteProject record) {
        return voteProjectDao.insertSelective(record);
    }

    @Transactional
    public VoteProject selectById(Long id) {
        return voteProjectDao.selectByPrimaryKey(id);
    }

    @Transactional
    public int update(VoteProject record) {
        return voteProjectDao.updateByPrimaryKeySelective(record);
    }

    @Override
    @Transactional
    public List<VoteProject> findAllVote() {
        return voteProjectDao.findAllVote();
    }

    @Override
    @Transactional
    public List<VoteProject> selectByIsClose(boolean isClose) {
        return voteProjectDao.selectByIsClose(isClose);
    }

    @Override
    @Transactional
    public List<VoteProject> findVote(HashMap<String, Object> map) {
        return voteProjectDao.findVote(map);
    }

    @Override
    @Transactional
    public List<VoteProject> findNoVote(HashMap<String, Object> map) {
        return voteProjectDao.findNoVote(map);
    }

    @Override
    @Transactional
    public List<VoteProject> findVoted(HashMap<String, Object> map) {
        return voteProjectDao.findVoted(map);
    }
}
