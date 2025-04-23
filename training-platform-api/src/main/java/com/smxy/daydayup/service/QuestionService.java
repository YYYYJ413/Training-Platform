package com.smxy.daydayup.service;

import com.smxy.daydayup.pojo.Question;
import com.smxy.daydayup.pojo.QuestionDTO;

import java.util.List;

public interface QuestionService {
    List<Question> getQuestionsByUserIdAndCourseId(String userId, int courseId);
    void createQuestion(String userId, int courseId, String questionContent);
    void deleteQuestion(int questionId);
    List<QuestionDTO> getAllQuestions();
    boolean updateQuestionAnswer(int questionId, String newAnswer);
}

