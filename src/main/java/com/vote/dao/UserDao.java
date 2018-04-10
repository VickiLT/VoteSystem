package com.vote.dao;

import com.vote.entity.User;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by sunwe on 2018/3/7.
 */
@Repository
public interface UserDao {
    int deleteByPrimaryKey(Integer id);

    int insert(User record);

    int insertSelective(User record);

    User selectByPrimaryKey(Integer id);

    List<User> findUserByName(String name);

    int updateByPrimaryKey(User record);

    int updateByPrimaryKeySelective(User record);

    List<User> findAllUser();

    User selectUserByName(String name);
}
