package com.vote.entity;

/**
 * Created by sunwe on 2018/5/17.
 */
public class Details {
    private Long id;
    private Long voteProjectId;
    private String voter;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getVoteProjectId() {
        return voteProjectId;
    }

    public void setVoteProjectId(Long voteProjectId) {
        this.voteProjectId = voteProjectId;
    }

    public String getVoter() {
        return voter;
    }

    public void setVoter(String voter) {
        this.voter = voter;
    }
}
