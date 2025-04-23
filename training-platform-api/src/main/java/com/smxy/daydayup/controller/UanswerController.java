package com.smxy.daydayup.controller;

import com.smxy.daydayup.pojo.Uanswer;
import com.smxy.daydayup.service.UanswerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class UanswerController {

    @Autowired
    private UanswerService uanswerService;


    @GetMapping("/filter")
    public List<Uanswer> getUanswersByUserAndExam(@RequestParam String userId, @RequestParam int examId,@RequestParam int retake) {
        return uanswerService.getUanswersByUserAndExam(userId, examId,retake);
    }
}
