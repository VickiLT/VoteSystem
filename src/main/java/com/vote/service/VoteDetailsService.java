package com.vote.service;

import com.vote.entity.Details;
import com.vote.entity.VoteDetails;

import java.util.List;

/**
 * 投票信息统计service
 * Created by sunwe on 2018/3/7.
 */
public interface VoteDetailsService {
    int deleteByPrimaryKey(Long id);

    int insert(VoteDetails record);

    VoteDetails selectByPrimaryKey(Long id);

    int updateByPrimaryKey(VoteDetails record);

    VoteDetails selectByProjectIdAndVoter(long id,String name);

    int deleteByProjectId(Long id);

    List<VoteDetails> selectByVoter(String name);

    int insert1(Details details);

    List<VoteDetails> findByProjectId(Long id);

}
