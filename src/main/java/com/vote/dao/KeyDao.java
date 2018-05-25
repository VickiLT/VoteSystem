package com.vote.dao;

import com.vote.entity.Key;
import org.springframework.stereotype.Repository;

@Repository
public interface KeyDao {
    int deleteByPrimaryKey(Long id);

    int insert(Key record);

    int insertSelective(Key record);

    Key selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(Key record);

    int updateByPrimaryKey(Key record);

    Key selectByVoteId(Long voteDetailsId);
}