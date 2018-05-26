package com.vote.service.Impl;

import com.vote.entity.VoteProject;
import com.vote.service.VoteEndTimeJobService;
import com.vote.service.VoteProjectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

/**
 * Created by sunwe on 2018/3/29.
 */
@Service
public class VoteEndTimeJobServiceImpl implements VoteEndTimeJobService{
    @Autowired
    private VoteProjectService voteProjectService;
    public void voteEndTimeJobMethod() {
        List<VoteProject> list = voteProjectService.findAllVote();
        for (VoteProject vo:list) {
            Date date = new Date();
            if(vo.getEndTime().getTime()<=date.getTime()){
                vo.setClose(false);
                voteProjectService.update(vo);
            }else {
                vo.setClose(true);
                voteProjectService.update(vo);
            }
        }
    }
}
