package com.smxy.daydayup.mapper;

import com.smxy.daydayup.pojo.Question;
import com.smxy.daydayup.pojo.QuestionDTO;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface QuestionMapper {
    List<Question> getQuestionsByUserIdAndCourseId(@Param("userId") String userId, @Param("courseId") int courseId);
    void insertQuestion(@Param("userId") String userId, @Param("courseId") int courseId, @Param("questionContent") String questionContent);
    void deleteQuestion(@Param("questionId") int questionId);
    List<QuestionDTO> getAllQuestions();
    int updateQuestionAnswer(@Param("questionId") int questionId, @Param("questionAnswer") String questionAnswer);
}
