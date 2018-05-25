package com.vote.dao;

import com.vote.entity.File;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface FileDao {
    int deleteByPrimaryKey(Long id);

    int insert(File record);

    int insertSelective(File record);

    File selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(File record);

    int updateByPrimaryKey(File record);

    List<File> selectByVoteProjectId(Long voteProjectId);
}