package com.vote.service;

import com.vote.entity.Person;

/**
 * Created by sunwe on 2018/3/31.
 */
public interface SessionService {
    public void changeLogin4Me(Person person);
    public Boolean checkLoginIsMe(Person person);
}
