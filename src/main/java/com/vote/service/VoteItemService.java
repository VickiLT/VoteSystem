package com.vote.service;

import com.vote.entity.VoteItem;

import java.util.List;

/**
 * 投票选项管理service
 * Created by sunwe on 2018/3/7.
 */
public interface VoteItemService {
    int deleteById(long id);

    int insert(VoteItem record);

    VoteItem selectById(Integer id);

    int update(VoteItem record);

    List<VoteItem> selectByVoteProjectId(long id);

    VoteItem selectByProjectIdAndNumber(long id,String number);

    int deleteByProjectId(long id);
}
