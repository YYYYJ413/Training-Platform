package com.smxy.daydayup.service;

import com.smxy.daydayup.pojo.UserCourses;

import java.util.List;

public interface UserCoursesService {
    int countUsersByCourseId(int courseId);
    List<UserCourses> findAll();
}

