package com.vote.service.Impl;

import com.vote.dao.DetailsDao;
import com.vote.entity.Details;
import com.vote.service.DetailsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Created by sunwe on 2018/5/17.
 */
@Service
public class DetailsServiceImpl implements DetailsService {

    @Autowired
    private DetailsDao detailsDao;

    @Override
    public int deleteByPrimaryKey(Long id) {
        return 0;
    }

    @Override
    public int insert(Details record) {
        return 0;
    }

    @Override
    public int insertSelective(Details record) {
        return 0;
    }

    @Override
    public Details selectByPrimaryKey(Long id) {
        return null;
    }

    @Override
    public int updateByPrimaryKeySelective(Details record) {
        return 0;
    }

    @Override
    public int updateByPrimaryKey(Details record) {
        return 0;
    }

    @Override
    @Transactional
    public Details selectByProjectIdAndVoter(long id, String name) {
        return detailsDao.selectByProjectIdAndVoter(id,name);
    }
}
