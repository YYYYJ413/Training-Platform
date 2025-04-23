package com.smxy.daydayup.service;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.smxy.daydayup.pojo.Exam;

import java.util.List;

public interface ExamService extends IService<Exam> {
    List<Exam> getMyExam(String userId);
    List<Exam> getAllExam();
    Exam getExamById(Integer examId);
}
