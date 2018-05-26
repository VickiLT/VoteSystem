package com.vote.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * Created by sunwe on 2018/3/26.
 */
public class VoteProjectVo {
    private long id;
    //投票标题
    private String voteTitle;
    //子选项
    private String voteSum;

    private String image;
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss",timezone="GMT+8")
    private Date createTime;
    //投票截至时间
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss",timezone="GMT+8")
    private Date endTime;
    //投票模式；1表示多选模式，0表示单选模式
    private String voteMode;
    //多选模式下需要选择的个数
    private int selectNum;
    //用户是否可以查看投票结果;1可查看;0不可查看
    private String isCheckResults;
    //用户在截止时间前是否可以修改选择结果;1可修改,0不可修改
    private String isModifyVote;
    //投票是否关闭；1未关闭，0已关闭
    private String isClose;
    //选项内容数组;
    private String[] content;

    private String time;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getVoteTitle() {
        return voteTitle;
    }

    public void setVoteTitle(String voteTitle) {
        this.voteTitle = voteTitle;
    }

    public String getVoteSum() {
        return voteSum;
    }

    public void setVoteSum(String voteSum) {
        this.voteSum = voteSum;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public String getVoteMode() {
        return voteMode;
    }

    public void setVoteMode(String voteMode) {
        this.voteMode = voteMode;
    }

    public int getSelectNum() {
        return selectNum;
    }

    public void setSelectNum(int selectNum) {
        this.selectNum = selectNum;
    }

    public String getIsCheckResults() {
        return isCheckResults;
    }

    public void setIsCheckResults(String isCheckResults) {
        this.isCheckResults = isCheckResults;
    }

    public String getIsModifyVote() {
        return isModifyVote;
    }

    public void setIsModifyVote(String isModifyVote) {
        this.isModifyVote = isModifyVote;
    }

    public String getIsClose() {
        return isClose;
    }

    public void setIsClose(String isClose) {
        this.isClose = isClose;
    }

    public String[] getContent() {
        return content;
    }

    public void setContent(String[] content) {
        this.content = content;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }
}
