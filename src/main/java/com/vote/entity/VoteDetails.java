package com.vote.entity;

import java.util.Date;

/**
 * Created by sunwe on 2018/3/6.
 */
/*投票信息统计表*/
public class VoteDetails {
    private long id;

    private long voteProjectId;
    //投票人用户名
    private String voterName;
    //选项集合
    private String voteSelects;
    //投票时间
    private Date voteTime;
    //

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public long getVoteProjectId() {
        return voteProjectId;
    }

    public void setVoteProjectId(long voteProjectId) {
        this.voteProjectId = voteProjectId;
    }

    public String getVoterName() {
        return voterName;
    }

    public void setVoterName(String voterName) {
        this.voterName = voterName;
    }

    public String getVoteSelects() {
        return voteSelects;
    }

    public void setVoteSelects(String voteSelects) {
        this.voteSelects = voteSelects;
    }

    public Date getVoteTime() {
        return voteTime;
    }

    public void setVoteTime(Date voteTime) {
        this.voteTime = voteTime;
    }
}
