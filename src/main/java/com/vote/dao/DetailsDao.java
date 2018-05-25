package com.vote.dao;

import com.vote.entity.Details;
import org.springframework.stereotype.Repository;

@Repository
public interface DetailsDao {
    int deleteByPrimaryKey(Long id);

    int insert(Details record);

    int insertSelective(Details record);

    Details selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(Details record);

    int updateByPrimaryKey(Details record);

    Details selectByProjectIdAndVoter(long id, String name);
}