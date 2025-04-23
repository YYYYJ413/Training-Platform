package com.smxy.daydayup.service.Impl;

import com.smxy.daydayup.mapper.UserCoursesMapper;
import com.smxy.daydayup.pojo.UserCourses;
import com.smxy.daydayup.service.UserCoursesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserCoursesServiceImpl implements UserCoursesService {

    @Autowired
    private UserCoursesMapper userCoursesMapper;

    @Override
    public int countUsersByCourseId(int courseId) {
        return userCoursesMapper.countUsersByCourseId(courseId);
    }

    @Override
    public List<UserCourses> findAll() {
        return userCoursesMapper.findAll();
    }
}

