package com.smxy.daydayup.mapper;

import com.smxy.daydayup.pojo.UserCourses;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface UserCoursesMapper {

    int countUsersByCourseId(int courseId);
    @Select("SELECT * FROM sm_user_courses")
    List<UserCourses> findAll();
}

