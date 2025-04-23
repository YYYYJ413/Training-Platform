package com.smxy.daydayup.service;

import com.smxy.daydayup.pojo.CourseTake;
import com.smxy.daydayup.pojo.dto.StudyCourseInfo;

/**
  * @team daydayup
  * @time 2021-12-06 21:45
  */
public interface CourseTakeService {


    int deleteByPrimaryKey(Long courseScoreId);

    int insert(CourseTake record);

    int insertSelective(CourseTake record);

    CourseTake selectByPrimaryKey(Long courseScoreId);

    int updateByPrimaryKeySelective(CourseTake record);

    int updateByPrimaryKey(CourseTake record);

    int insertStudyCourse(StudyCourseInfo studyCourseInfo);
}
