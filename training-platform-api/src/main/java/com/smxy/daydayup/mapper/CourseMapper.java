package com.smxy.daydayup.mapper;

import com.smxy.daydayup.pojo.Course;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface CourseMapper {
    int deleteCourse(String courseId);

    int insert(Course record);

    int insertSelective(Course record);

    Course findCourse(Integer courseId);

    int updateByPrimaryKeySelective(Course record);

    int updateByPrimaryKey(Course record);

    List<Course> selectCourse(@Param("userId") String userId);

    List<Course> selectprofessorCourse(@Param("userId") String userId);

    Course selectByPrimaryKey(@Param("courseId") Integer courseId);

    List<Course> selectAll();

    String selectCode(String code);
}