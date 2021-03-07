package com.petcom.community.util;


import com.petcom.community.entity.User;
import org.springframework.stereotype.Component;

/**
 * Keep user info,
 */
@Component
public class HostHolder {

    private ThreadLocal<User> users = new ThreadLocal<>();

    public void setUser(User user) {
        users.set(user);
    }

    public User getUser() {
        return users.get();
    }

    public void clear() {
        users.remove();
    }

}