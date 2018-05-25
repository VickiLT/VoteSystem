package com.vote.service.Impl;

import com.vote.dao.FileDao;
import com.vote.entity.File;
import com.vote.service.FileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by sunwe on 2018/5/17.
 */
@Service
public class FileServiceImpl implements FileService {

    @Autowired
    private FileDao fileDao;
    @Transactional
    @Override
    public int deleteByPrimaryKey(Long id) {
        return 0;
    }

    @Override
    @Transactional
    public int insert(File record) {
        return 0;
    }

    @Override
    @Transactional
    public int insertSelective(File record) {
        return fileDao.insertSelective(record);
    }

    @Override
    @Transactional
    public File selectByPrimaryKey(Long id) {
        return null;
    }

    @Override
    @Transactional
    public int updateByPrimaryKeySelective(File record) {
        return 0;
    }

    @Override
    @Transactional
    public int updateByPrimaryKey(File record) {
        return 0;
    }

    @Override
    public List<File> selectByVoteProjectId(Long voteProjectId) {
        return fileDao.selectByVoteProjectId(voteProjectId);
    }
}
