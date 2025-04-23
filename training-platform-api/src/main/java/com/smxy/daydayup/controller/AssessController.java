package com.smxy.daydayup.controller;

import com.smxy.daydayup.pojo.Assess;
import com.smxy.daydayup.service.AssessService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.List;

@RestController
@RequestMapping("/assess")
public class AssessController {

    @Autowired
    private AssessService assessService;

    @PostMapping("/create")
    public String createAssess(@RequestParam String userId,
                               @RequestParam int courseId,
                               @RequestParam BigDecimal assessScore,
                               @RequestParam String assessContent){
        assessService.createAssess(userId, courseId, assessScore, assessContent);
        return "Assess created successfully!";
    }

    @GetMapping("/average/{courseId}")
    public ResponseEntity<BigDecimal> getAverageAssessScore(@PathVariable int courseId) {
        BigDecimal averageScore = assessService.calculateAverageAssessScore(courseId);

        if (averageScore == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null); // 如果没有找到分数，返回404
        }

        return ResponseEntity.ok(averageScore);
    }

    @GetMapping("/all")
    public ResponseEntity<List<Assess>> getAllAssessInfo() {
        List<Assess> assessList = assessService.findAllAssessInfo();
        if (assessList == null || assessList.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
        }
        return ResponseEntity.ok(assessList);
    }
}
