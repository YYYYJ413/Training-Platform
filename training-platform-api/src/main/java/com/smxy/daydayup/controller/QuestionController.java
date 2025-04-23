package com.smxy.daydayup.controller;

import com.smxy.daydayup.pojo.Question;
import com.smxy.daydayup.pojo.QuestionDTO;
import com.smxy.daydayup.service.QuestionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/questions")
public class QuestionController {

    @Autowired
    private QuestionService questionService;

    @GetMapping
    public List<Question> getQuestions(@RequestParam String userId, @RequestParam int courseId) {
        return questionService.getQuestionsByUserIdAndCourseId(userId, courseId);
    }

    @PostMapping
    public void createQuestion(@RequestParam String userId, @RequestParam int courseId, @RequestParam String questionContent) {
        questionService.createQuestion(userId, courseId, questionContent);
    }

    @DeleteMapping("/{questionId}")
    public void deleteQuestion(@PathVariable int questionId) {
        questionService.deleteQuestion(questionId);
    }

    @GetMapping("/all")
    public ResponseEntity<List<QuestionDTO>> getAllQuestions() {
        List<QuestionDTO> questions = questionService.getAllQuestions();
        return ResponseEntity.ok(questions);
    }
    @PutMapping("/answer/{questionId}")
    public ResponseEntity<String> updateQuestionAnswer(@PathVariable int questionId, @RequestBody String newAnswer) {
        boolean updated = questionService.updateQuestionAnswer(questionId, newAnswer);
        if (updated) {
            return ResponseEntity.ok("Answer updated successfully");
        } else {
            return ResponseEntity.status(404).body("Question not found");
        }
    }
}

