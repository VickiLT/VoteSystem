package com.vote.service;

import com.vote.entity.Details;

/**
 * Created by sunwe on 2018/5/17.
 */
public interface DetailsService {
    int deleteByPrimaryKey(Long id);

    int insert(Details record);

    int insertSelective(Details record);

    Details selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(Details record);

    int updateByPrimaryKey(Details record);

    Details selectByProjectIdAndVoter(long id, String name);
}
