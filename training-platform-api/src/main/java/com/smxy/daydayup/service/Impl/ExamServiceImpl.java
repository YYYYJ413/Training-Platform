package com.smxy.daydayup.service.Impl;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.smxy.daydayup.mapper.ExamMapper;
import com.smxy.daydayup.pojo.Exam;
import com.smxy.daydayup.service.ExamService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class ExamServiceImpl extends ServiceImpl<ExamMapper, Exam> implements ExamService {
    @Autowired
    ExamMapper examMapper;

    public List<Exam> getMyExam(String userId){
        return examMapper.getMyExam(userId);
    }

    public List<Exam> getAllExam(){
        return examMapper.getAllExam();
    }

    @Override
    public Exam getExamById(Integer examId) {
        return examMapper.selectById(examId);
    }
}
