package com.smxy.daydayup.service.Impl;

import com.smxy.daydayup.mapper.AssessMapper;
import com.smxy.daydayup.pojo.Assess;
import com.smxy.daydayup.service.AssessService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Objects;

@Service
public class AssessServiceImpl implements AssessService {

    @Autowired
    private AssessMapper assessMapper;

    @Override
    public void createAssess(String userId, int courseId, BigDecimal assessScore, String assessContent) {
        Assess assess = new Assess();
        assess.setUserId(userId);
        assess.setCourseId(courseId);
        assess.setAssessScore(assessScore);
        assess.setAssessContent(assessContent);
        assess.setTimeCreate(LocalDateTime.now());
        assess.setTimeModify(LocalDateTime.now());
        assessMapper.insertAssess(assess);
    }

    @Override
    public BigDecimal calculateAverageAssessScore(int courseId) {
        List<BigDecimal> scores = assessMapper.findScoresByCourseId(courseId);

        // 检查 scores 是否为 null 或空
        if (scores == null || scores.isEmpty()) {
            return BigDecimal.ZERO; // 或者根据设计选择返回 null
        }

        // 计算总分
        BigDecimal totalScore = scores.stream()
                .filter(Objects::nonNull) // 过滤掉 null 值
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        // 计算平均分
        return totalScore.divide(BigDecimal.valueOf(scores.size()), 2, RoundingMode.HALF_UP);
    }

    @Override
    public List<Assess> findAllAssessInfo() {
        return assessMapper.findAllAssessInfo();
    }

}
