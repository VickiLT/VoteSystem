package com.vote.dao;

import com.vote.entity.Manager;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by sunwe on 2018/3/7.
 */
@Repository
public interface ManagerDao {
    int deleteByPrimaryKey(Integer id);

    int insert(Manager record);

    int insertSelective(Manager record);

    Manager selectByPrimaryKey(Integer id);

    Manager selectManagerByName(String name);

    List<Manager> findManagerByName(String name);

    int updateByPrimaryKey(Manager record);

    int updateByPrimaryKeySelective(Manager record);

    List<Manager> selectManager();
}
