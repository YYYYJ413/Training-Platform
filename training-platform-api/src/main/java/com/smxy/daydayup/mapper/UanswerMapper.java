package com.smxy.daydayup.mapper;

import com.smxy.daydayup.pojo.Uanswer;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface UanswerMapper {
    List<Uanswer> getUanswersByUserAndExam(@Param("userId") String userId, @Param("examId") int examId,@Param("retake")int retake);
}
