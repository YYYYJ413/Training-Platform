package com.smxy.daydayup.mapper;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.smxy.daydayup.pojo.Exam;

import java.util.List;

public interface ExamMapper extends BaseMapper<Exam> {
    List<Exam> getMyExam(String userId);
    List<Exam> getAllExam();
    Exam selectById(Integer examId);
}
