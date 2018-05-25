package com.vote.entity;

public class Key {
    private Long id;

    private Long voteDetailsId;

    private String r1;

    private String r2;

    private String et1;

    private Integer num1;

    private String et2;

    private Integer num2;

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

    public String getEt1() {
        return et1;
    }

    public void setEt1(String et1) {
        this.et1 = et1 == null ? null : et1.trim();
    }

    public Integer getNum1() {
        return num1;
    }

    public void setNum1(Integer num1) {
        this.num1 = num1;
    }

    public String getEt2() {
        return et2;
    }

    public void setEt2(String et2) {
        this.et2 = et2 == null ? null : et2.trim();
    }

    public Integer getNum2() {
        return num2;
    }

    public void setNum2(Integer num2) {
        this.num2 = num2;
    }
}