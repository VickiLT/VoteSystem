package com.vote.entity;

/**
 * Created by sunwe on 2018/3/6.
 */
/*投票选项类*/
public class VoteItem {
    private long id;
    //投票项目id
    private long voteProjectId;
    //选项内容
    private String voteItemContent;
    //选项编号
    private String voteItemNumber;
    //选项票数
    private int voteItemPoll;
    //

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

    public String getVoteItemContent() {
        return voteItemContent;
    }

    public void setVoteItemContent(String voteItemContent) {
        this.voteItemContent = voteItemContent;
    }

    public String getVoteItemNumber() {
        return voteItemNumber;
    }

    public void setVoteItemNumber(String voteItemNumber) {
        this.voteItemNumber = voteItemNumber;
    }

    public int getVoteItemPoll() {
        return voteItemPoll;
    }

    public void setVoteItemPoll(int voteItemPoll) {
        this.voteItemPoll = voteItemPoll;
    }
}
