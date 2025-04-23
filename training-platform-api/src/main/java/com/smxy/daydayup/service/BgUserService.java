package com.smxy.daydayup.service;

import com.smxy.daydayup.pojo.User;

import java.util.List;

public interface BgUserService {
    List<User> getAllUsers();
    User addUser(User user);
    void deleteUser(String userId);
    boolean updateUser(String userId, User user);
    User findById(String userId);
}

