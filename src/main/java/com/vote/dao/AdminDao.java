package com.vote.dao;

import com.vote.entity.Admin;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by wh on 2018/6/7.
 */
@Repository
public interface AdminDao {
    int deleteByPrimaryKey(Integer id);

    int insert(Admin record);

    int insertSelective(Admin record);

    Admin selectByPrimaryKey(Integer id);

    Admin selectAdminByName(String name);
    Admin selectAdminByCode(String code);
    List<Admin> findAdminByName(String name);

    int updateByPrimaryKey(Admin record);

    int updateByPrimaryKeySelective(Admin record);

    List<Admin> selectAdmin();

    int updateByCode(String code);
}
