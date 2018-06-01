package com.vote.dao;

import com.vote.entity.Details;
import com.vote.entity.VoteDetails;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by sunwe on 2018/3/7.
 */
@Repository
public interface VoteDetailsDao {
    int deleteByPrimaryKey(Long id);

    int insert(VoteDetails record);

    int insertSelective(VoteDetails record);

    VoteDetails selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(VoteDetails record);

    int updateByPrimaryKey(VoteDetails record);

    VoteDetails selectByProjectIdAndVoter(long id,String name);

    int deleteByProjectId(Long id);

    List<VoteDetails> selectByVoter(String name);

    int insert1(Details details);

    List<VoteDetails> findByProjectId(Long id);
}
