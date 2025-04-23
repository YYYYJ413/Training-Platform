package com.smxy.daydayup.controller;

import com.smxy.daydayup.pojo.Progress;
import com.smxy.daydayup.service.Impl.ProgressServiceImpl;
import com.smxy.daydayup.service.ProgressService;
import com.smxy.daydayup.util.result.ReturnResult;
import io.swagger.annotations.ApiModelProperty;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/progress")
public class ProgressController {

    @Autowired
    private ProgressServiceImpl progressService;

    @GetMapping("/status")
    public boolean getProgressStatus(@RequestParam String userId,
                                     @RequestParam int courseId,
                                     @RequestParam int chapterId) {
        return progressService.getIsFinished(userId, courseId, chapterId);
    }

    @ApiModelProperty(value="获取progressId")
    @GetMapping("get")
    public Progress getProgress(@RequestParam String userId,
                                @RequestParam int courseId,
                                @RequestParam int chapterId){
        return progressService.getProgress(userId, courseId, chapterId);
    }

    @GetMapping("/all")
    public List<Progress> getAllProgress() {
        return progressService.findAll();
    }

    @PostMapping("/add")
    public ReturnResult addProgress(@RequestBody Progress progress) {
        return progressService.addProgress(progress);
    }

    @PostMapping("/update")
    public ReturnResult updateProgress(@RequestBody Progress progress) {
        return progressService.updateProgress(progress);
    }

    @GetMapping("/finished-chapters/{userId}")
    public ResponseEntity<List<String>> getFinishedChapters(@PathVariable String userId) {
        List<String> chapterContents = progressService.getFinishedChapterContents(userId);
        return ResponseEntity.ok(chapterContents);
    }

    @GetMapping("/finished-count/{userId}")
    public ResponseEntity<Integer> getFinishedCount(@PathVariable String userId) {
        int count = progressService.getFinishedCount(userId);
        return ResponseEntity.ok(count);
    }
}

