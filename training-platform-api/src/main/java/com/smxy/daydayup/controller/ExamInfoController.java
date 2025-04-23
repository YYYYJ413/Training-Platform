package com.smxy.daydayup.controller;
import com.smxy.daydayup.pojo.ExamInfo;
import com.smxy.daydayup.pojo.dto.UserScoreDTO;
import com.smxy.daydayup.service.ExamInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/examinfo")
public class ExamInfoController {
    @Autowired
    private ExamInfoService examInfoService;

    @GetMapping("/remainingRetakes")
    public int getRemainingRetakes(@RequestParam int examId, @RequestParam String userId) {
        return examInfoService.getRemainingRetakes(examId, userId);
    }

    @GetMapping("/maxRetakes")
    public int getMaxRetake(@RequestParam int examId, @RequestParam String userId) {
        return examInfoService.getMaxRetake(examId, userId);
    }

    @GetMapping("/maxScore")
    public float getMaxScore(@RequestParam int examId, @RequestParam String userId) {
        return examInfoService.getMaxScore(examId, userId);
    }

    @GetMapping("/info")
    public ExamInfo getExamInfo(@RequestParam int examId) {
        return examInfoService.getExamInfo(examId);
    }

    @GetMapping("/userOfExam/{examId}")
    public List<UserScoreDTO> getUserOfExam(@PathVariable("examId") int examId) {
        return examInfoService.getUserOfExam(examId);
    }
}
