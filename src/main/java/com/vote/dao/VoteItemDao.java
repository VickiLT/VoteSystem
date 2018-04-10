package com.vote.dao;

import com.vote.entity.VoteItem;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by sunwe on 2018/3/7.
 */
@Repository
public interface VoteItemDao {
    int deleteByPrimaryKey(long id);

    int insert(VoteItem record);

    int insertSelective(VoteItem record);

    VoteItem selectByPrimaryKey(long id);

    int updateByPrimaryKeySelective(VoteItem record);

    int updateByPrimaryKey(VoteItem record);

    List<VoteItem> selectByVoteProjectId(long id);

    VoteItem selectByProjectIdAndNumber(long id,String number);

    int deleteByProjectId(long id);
}
