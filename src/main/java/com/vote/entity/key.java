package com.vote.entity;

public class key {
    private Long id;

    private Long voteDetailsId;

    private String r1;

    private String r2;

    private String et;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getVoteDetailsId() {
        return voteDetailsId;
    }

    public void setVoteDetailsId(Long voteDetailsId) {
        this.voteDetailsId = voteDetailsId;
    }

    public String getR1() {
        return r1;
    }

    public void setR1(String r1) {
        this.r1 = r1 == null ? null : r1.trim();
    }

    public String getR2() {
        return r2;
    }

    public void setR2(String r2) {
        this.r2 = r2 == null ? null : r2.trim();
    }

    public String getEt() {
        return et;
    }

    public void setEt(String et) {
        this.et = et == null ? null : et.trim();
    }
}