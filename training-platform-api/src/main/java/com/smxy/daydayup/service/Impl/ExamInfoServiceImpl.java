package com.smxy.daydayup.service.Impl;

import com.smxy.daydayup.mapper.ExamInfoMapper;
import com.smxy.daydayup.pojo.ExamInfo;
import com.smxy.daydayup.pojo.dto.UserScoreDTO;
import com.smxy.daydayup.service.ExamInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ExamInfoServiceImpl implements ExamInfoService {

    @Autowired
    private ExamInfoMapper examInfoMapper;

    @Override
    public int getRemainingRetakes(int examId, String userId) {
        ExamInfo examInfo = examInfoMapper.getExamInfoById(examId);
        int maxRetake = examInfoMapper.getMaxRetake(examId, userId);
        return examInfo.getRetakeAllowed() + 1 - maxRetake;
    }

    @Override
    public int getMaxRetake(int examId, String userId) {
        ExamInfo examInfo = examInfoMapper.getExamInfoById(examId);
        int maxRetake = examInfoMapper.getMaxRetake(examId, userId);
        return maxRetake;
    }

    @Override
    public float getMaxScore(int examId, String userId) {
        return examInfoMapper.getMaxUserScore(examId, userId);
    }

    @Override
    public ExamInfo getExamInfo(int examId) {
        return examInfoMapper.getExamInfoById(examId);
    }

    @Override
    public List<UserScoreDTO> getUserOfExam(int examId) {
        return examInfoMapper.getUserOfExam(examId);
    }
}
