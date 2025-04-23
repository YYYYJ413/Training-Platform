package com.smxy.daydayup.controller;

import com.smxy.daydayup.pojo.Uexam;
import com.smxy.daydayup.service.UexamService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.fasterxml.jackson.databind.ObjectMapper; // 导入 ObjectMapper
import org.springframework.http.HttpStatus; // 导入 HttpStatus
import org.springframework.http.ResponseEntity; // 导入 ResponseEntity

import java.util.Map;

@RestController
@RequestMapping("/uexam")
public class UexamController {

    @Autowired
    private UexamService uexamService;

    private final ObjectMapper objectMapper = new ObjectMapper(); // 创建 ObjectMapper 实例

    @PostMapping("/add")
    public ResponseEntity<String> addUexam(@RequestBody String json) {
        try {
            // 将 JSON 字符串解析为 Map
            Map<String, Object> requestBody = objectMapper.readValue(json, Map.class);

            // 从请求体中提取参数
            int examId = (int) requestBody.get("examId");
            String userId = (String) requestBody.get("userId");
            int retake = (int) requestBody.get("retake");
            int itemId = (int) requestBody.get("itemId");
            Integer optionId = (Integer) requestBody.get("optionId"); // 使用 Integer 以便可以为 null
            String answer = (String) requestBody.get("answer");

            Uexam uexam = new Uexam();
            uexam.setExamId(examId);
            uexam.setUserId(userId);
            uexam.setRetake(retake);
            uexam.setItemId(itemId);
            uexam.setOptionId(optionId);
            uexam.setAnswer(answer);
            uexamService.addUexam(uexam);
            return ResponseEntity.ok("Uexam added successfully");
        } catch (Exception e) {
        e.printStackTrace(); // 打印异常信息
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Invalid request: " + e.getMessage());
    }

}
}
