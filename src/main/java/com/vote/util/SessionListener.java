package com.vote.util;

import com.vote.entity.Person;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;
import java.util.*;

/**
 * Created by sunwe on 2018/3/31.
 */
public class SessionListener implements HttpSessionListener {
    // key为sessionId，value为HttpSession，使用static，定义静态变量，使之程序运行时，一直存在内存中。
    private static Map<String, HttpSession> sessionMap = new HashMap<String, HttpSession>(500);

    /**
     * HttpSessionListener中的方法，在创建session
     */
    @Override
    public void sessionCreated(HttpSessionEvent event) {
        // TODO Auto-generated method stub
    }

    /**
     * HttpSessionListener中的方法，回收session时,删除sessionMap中对应的session
     */
    @Override
    public void sessionDestroyed(HttpSessionEvent event) {
        getSessionMap().remove(event.getSession().getId());
    }

    /**
     * 得到在线用户会话集合
     */
    public static List<HttpSession> getUserSessions() {
        List<HttpSession> list = new ArrayList<HttpSession>();
        Iterator<String> iterator = getSessionMapKeySetIt();
        while (iterator.hasNext()) {
            String key = iterator.next();
            HttpSession session = getSessionMap().get(key);
            list.add(session);
        }
        return list;
    }

    /**
     * 得到用户对应会话map，key为用户ID,value为会话ID
     */
    public static Map<String, String> getUserSessionMap() {
        Map<String, String> map = new HashMap<String, String>();
        Iterator<String> iter = getSessionMapKeySetIt();
        while (iter.hasNext()) {
            String sessionId = iter.next();
            HttpSession session = getSessionMap().get(sessionId);
            Person person = (Person) session.getAttribute("person");
            if (person != null) {
                map.put(person.getName(), sessionId);
            }
        }
        return map;
    }

    /**
     * 移除用户Session
     */
    public synchronized static void removeUserSession(String name) {
        Map<String, String> userSessionMap = getUserSessionMap();
        if (userSessionMap.containsKey(name)) {
            String sessionId = userSessionMap.get(name);
            //getSessionMap().get(sessionId).invalidate();
            getSessionMap().remove(sessionId);
        }
    }

    /**
     * 增加用户到session集合中
     */
    public static void addUserSession(HttpSession session) {
        getSessionMap().put(session.getId(), session);
    }

    /**
     * 移除一个session
     */
    public static void removeSession(String sessionID) {
        getSessionMap().remove(sessionID);
    }

    public static boolean containsKey(String key) {
        return getSessionMap().containsKey(key);
    }

    /**
     * 判断该用户是否已重复登录，使用
     * 同步方法，只允许一个线程进入，才好验证是否重复登录
     * @param person
     * @return
     */
    public synchronized static boolean checkIfHasLogin(Person person) {
        Iterator<String> iter = getSessionMapKeySetIt();
        while (iter.hasNext()) {
            String sessionId = iter.next();
            HttpSession session = getSessionMap().get(sessionId);
            Person sessionuser = (Person) session.getAttribute("person");  // 这是你设置 保存用户对应session名
            if (sessionuser != null) {
                if (sessionuser.getName().equals(sessionuser.getName())){
                    return true;
                }
            }
        }
        return false;
    }

    /**
     * 获取在线的sessionMap
     */
    public static Map<String, HttpSession> getSessionMap() {
        return sessionMap;
    }

    /**
     * 获取在线sessionMap中的SessionId
     */
    public static Iterator<String> getSessionMapKeySetIt() {
        return getSessionMap().keySet().iterator();
    }
}
