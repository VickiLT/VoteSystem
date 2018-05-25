package com.vote.service;

import com.vote.entity.File;

import java.util.List;

/**
 * Created by sunwe on 2018/5/17.
 */
public interface FileService {
    int deleteByPrimaryKey(Long id);

    int insert(File record);

    int insertSelective(File record);

    File selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(File record);

    int updateByPrimaryKey(File record);

    List<File> selectByVoteProjectId(Long voteProjectId);
}
