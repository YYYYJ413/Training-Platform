package com.smxy.daydayup.service.Impl;

import com.smxy.daydayup.mapper.QuestionMapper;
import com.smxy.daydayup.pojo.Question;
import com.smxy.daydayup.pojo.QuestionDTO;
import com.smxy.daydayup.service.QuestionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class QuestionServiceImpl implements QuestionService {

    @Autowired
    private QuestionMapper questionMapper;

    @Override
    public List<Question> getQuestionsByUserIdAndCourseId(String userId, int courseId) {
        return questionMapper.getQuestionsByUserIdAndCourseId(userId, courseId);
    }

    @Override
    public void createQuestion(String userId, int courseId, String questionContent) {
        questionMapper.insertQuestion(userId, courseId, questionContent);
    }

    @Override
    public void deleteQuestion(int questionId) {
        questionMapper.deleteQuestion(questionId);
    }

    @Override
    public List<QuestionDTO> getAllQuestions() {
        return questionMapper.getAllQuestions();
    }

    @Override
    public boolean updateQuestionAnswer(int questionId, String newAnswer) {
        int rowsAffected = questionMapper.updateQuestionAnswer(questionId, newAnswer);
        return rowsAffected > 0; // If rows affected is greater than 0, the update was successful
    }
}

