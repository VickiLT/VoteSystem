package com.vote.entity;

public class File {
    private Long id;

    private Long voteProjectId;

    private String filename;

    private String filepath;

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

    public String getFilename() {
        return filename;
    }

    public void setFilename(String filename) {
        this.filename = filename == null ? null : filename.trim();
    }

    public String getFilepath() {
        return filepath;
    }

    public void setFilepath(String filepath) {
        this.filepath = filepath == null ? null : filepath.trim();
    }
}