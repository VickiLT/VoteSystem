package com.vote.service.Impl;

import com.vote.entity.Person;
import com.vote.service.SessionService;
import com.vote.util.ContextHolderUtils;
import com.vote.util.SessionListener;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;
import java.util.Map;

/**
 * Created by sunwe on 2018/3/31.
 */
@Service
public class SessionServiceImpl implements SessionService {
    @Override
    public void changeLogin4Me(Person person) {
        Boolean hasLogin = SessionListener.checkIfHasLogin(person);
        HttpSession session = ContextHolderUtils.getSession();
        if(hasLogin)
            SessionListener.removeUserSession(person.getName());
        SessionListener.addUserSession(session);
    }

    /**
     * 使用拦截器时，检查是否是当前session用户
     * @param person
     * @return
     */
    @Override
    public Boolean checkLoginIsMe(Person person) {
        if(null==person)
            return false;
        Map<String,String> SessionUser=   SessionListener.getUserSessionMap();
        String curSession=SessionUser.get(person.getName());
        HttpSession session = ContextHolderUtils.getSession();
        if(curSession.equals(session.getId()))
            return true;
        return false;
    }
}
