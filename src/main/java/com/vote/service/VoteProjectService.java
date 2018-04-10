package com.vote.service;

import com.vote.entity.VoteProject;

import java.util.HashMap;
import java.util.List;

/**
 * 投票项目管理service
 * Created by sunwe on 2018/3/7.
 */
public interface VoteProjectService {
    int deleteById(Long id);

    int insert(VoteProject record);

    VoteProject selectById(Long id);

    int update(VoteProject record);

    List<VoteProject> findAllVote();

    List<VoteProject> selectByIsClose(boolean isClose);

    List<VoteProject> findVote(HashMap<String,Object> map);

    List<VoteProject> findNoVote(HashMap<String,Object> map);

    List<VoteProject> findVoted(HashMap<String,Object> map);
}
