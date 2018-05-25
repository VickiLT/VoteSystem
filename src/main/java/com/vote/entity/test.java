package com.vote.entity;

import com.vote.service.Impl.KeyServiceImpl;

/**
 * Created by sunwe on 2018/5/17.
 */
public class test {
    public static void main(String[] args) {
        Key key = new Key();
        key.setVoteDetailsId(10l);
        key.setR1("ss");
        key.setR2("sss");
        key.setEt1("ssss");
        key.setEt2("sssss");
        key.setNum1(1);
        key.setNum2(2);
        KeyServiceImpl keyService = new KeyServiceImpl();
        keyService.insert(key);
    }
}
