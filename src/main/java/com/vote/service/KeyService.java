package com.vote.service;

import com.vote.entity.Key;

/**
 * Created by sunwe on 2018/5/16.
 */
public interface KeyService {
    int deleteByPrimaryKey(Long id);

    int insert(Key record);

    int insertSelective(Key record);

    Key selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(Key record);

    int updateByPrimaryKey(Key record);

    Key selectByVoteId(Long voteDetailsId);
}
