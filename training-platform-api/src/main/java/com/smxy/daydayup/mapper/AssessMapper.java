package com.smxy.daydayup.mapper;

import com.smxy.daydayup.pojo.Assess;
import org.apache.ibatis.annotations.Mapper;

import java.math.BigDecimal;
import java.util.List;

@Mapper
public interface AssessMapper {
    void insertAssess(Assess assess);
    List<BigDecimal> findScoresByCourseId(int courseId);
    List<Assess> findAllAssessInfo();
}
