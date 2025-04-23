package com.smxy.daydayup.controller;

import com.smxy.daydayup.pojo.Score;
import com.smxy.daydayup.service.ScoreService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/scores")
public class ScoreController {

    @Autowired
    private ScoreService scoreService;

    @PostMapping
    public String addScore(@RequestBody Score score) {
        scoreService.addScore(score);
        return "Score added successfully!";
    }
}
