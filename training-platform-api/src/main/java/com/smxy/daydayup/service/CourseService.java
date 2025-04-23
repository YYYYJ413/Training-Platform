package com.smxy.daydayup.service;

import com.smxy.daydayup.pojo.Course;
import com.smxy.daydayup.pojo.vo.CourseInfoPlusVO;
import com.smxy.daydayup.pojo.vo.CoursePlusVO;

import java.util.List;

public interface CourseService{
    int deleteCourse(String courseId);

    int insert(Course record);

    int insertSelective(Course record);

    Course findCourse(Integer courseId);

    int updateByPrimaryKeySelective(Course record);

    int updateByPrimaryKey(Course record);

    List<CourseInfoPlusVO> selectCourse(String userId);

    List<CoursePlusVO> selectprofessorCourse(String userId);

    Course selectByPrimaryKey(Integer courseId);

    List<Course> selectAll();
}
