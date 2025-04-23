package com.smxy.daydayup.mapper;
import com.smxy.daydayup.pojo.ExamInfo;
import com.smxy.daydayup.pojo.dto.UserScoreDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface ExamInfoMapper {
    ExamInfo getExamInfoById(int examId);
    int getMaxRetake(@Param("examId") int examId, @Param("userId") String userId);
    float getMaxUserScore(@Param("examId") int examId, @Param("userId") String userId);
    List<UserScoreDTO>getUserOfExam(Integer examId);
}

