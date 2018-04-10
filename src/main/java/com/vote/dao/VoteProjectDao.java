package com.vote.dao;

import com.vote.entity.VoteProject;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;

/**
 * Created by sunwe on 2018/3/7.
 */
@Repository
public interface VoteProjectDao {
    int deleteByPrimaryKey(Long id);

    int insert(VoteProject record);

    int insertSelective(VoteProject record);

    VoteProject selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(VoteProject record);

    int updateByPrimaryKey(VoteProject record);

    List<VoteProject> findAllVote();

    List<VoteProject> selectByIsClose(boolean isClose);

    List<VoteProject> findVote(HashMap<String,Object> map);

    List<VoteProject> findNoVote(HashMap<String,Object> map);

    List<VoteProject> findVoted(HashMap<String,Object> map);
}
