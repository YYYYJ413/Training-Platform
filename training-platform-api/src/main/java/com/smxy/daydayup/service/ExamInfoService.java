package com.smxy.daydayup.service;

import com.smxy.daydayup.pojo.ExamInfo;
import com.smxy.daydayup.pojo.dto.UserScoreDTO;

import java.util.List;

public interface ExamInfoService {
    int getRemainingRetakes(int examId, String userId);
    int getMaxRetake(int examId, String userId);
    float getMaxScore(int examId, String userId);
    ExamInfo getExamInfo(int examId);
    List<UserScoreDTO> getUserOfExam(int examId);
}

