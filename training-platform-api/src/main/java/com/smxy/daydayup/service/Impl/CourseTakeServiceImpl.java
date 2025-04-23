package com.smxy.daydayup.service.Impl;

import com.smxy.daydayup.mapper.CourseTakeMapper;
import com.smxy.daydayup.pojo.CourseTake;
import com.smxy.daydayup.pojo.dto.StudyCourseInfo;
import com.smxy.daydayup.service.CourseTakeService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
/**
  * @team daydayup
  * @time 2021-12-06 21:45
  */
@Service
public class CourseTakeServiceImpl implements CourseTakeService {

    @Resource
    private CourseTakeMapper courseTakeMapper;

    @Override
    public int deleteByPrimaryKey(Long courseScoreId) {
        return courseTakeMapper.deleteByPrimaryKey(courseScoreId);
    }

    @Override
    public int insert(CourseTake record) {
        return courseTakeMapper.insert(record);
    }

    @Override
    public int insertSelective(CourseTake record) {
        return courseTakeMapper.insertSelective(record);
    }

    @Override
    public CourseTake selectByPrimaryKey(Long courseScoreId) {
        return courseTakeMapper.selectByPrimaryKey(courseScoreId);
    }

    @Override
    public int updateByPrimaryKeySelective(CourseTake record) {
        return courseTakeMapper.updateByPrimaryKeySelective(record);
    }

    @Override
    public int updateByPrimaryKey(CourseTake record) {
        return courseTakeMapper.updateByPrimaryKey(record);
    }

    @Override
    public int insertStudyCourse(StudyCourseInfo studyCourseInfo) {
        return courseTakeMapper.insertStudyCourse(studyCourseInfo);
    }

}
