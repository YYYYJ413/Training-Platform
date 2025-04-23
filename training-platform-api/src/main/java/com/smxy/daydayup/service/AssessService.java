package com.smxy.daydayup.service;

import com.smxy.daydayup.pojo.Assess;

import java.math.BigDecimal;
import java.util.List;

public interface AssessService {
    void createAssess(String userId, int courseId, BigDecimal assessScore, String assessContent);
    BigDecimal calculateAverageAssessScore(int courseId);
    List<Assess> findAllAssessInfo();
}

