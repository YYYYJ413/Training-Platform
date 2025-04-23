package com.smxy.daydayup.service;

import com.smxy.daydayup.pojo.Progress;
import com.smxy.daydayup.util.result.ReturnResult;

import java.util.List;

public interface ProgressService {
    boolean getIsFinished(String userId, int courseId, int chapterId);
    ReturnResult addProgress(Progress progress);
    List<Progress> findAll();
    ReturnResult updateProgress(Progress progress);
    Progress getProgress(String userId, int courseId, int chapterId);
    List<String> getFinishedChapterContents(String userId);
    int getFinishedCount(String userId);
}

