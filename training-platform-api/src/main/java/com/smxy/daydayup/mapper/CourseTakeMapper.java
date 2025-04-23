package com.smxy.daydayup.mapper;

import com.smxy.daydayup.pojo.CourseTake;
import com.smxy.daydayup.pojo.dto.StudyCourseInfo;
import org.apache.ibatis.annotations.Mapper;

/**
  * @team daydayup
  * @time 2021-12-06 21:45
  */
@Mapper
public interface CourseTakeMapper {
    int deleteByPrimaryKey(Long courseScoreId);

    int insert(CourseTake record);

    int insertSelective(CourseTake record);

    CourseTake selectByPrimaryKey(Long courseScoreId);

    int updateByPrimaryKeySelective(CourseTake record);

    int updateByPrimaryKey(CourseTake record);

    int insertStudyCourse(StudyCourseInfo studyCourseInfo);
}