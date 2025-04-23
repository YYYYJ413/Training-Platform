package com.smxy.daydayup.service;

import com.smxy.daydayup.pojo.Uanswer;

import java.util.List;

public interface UanswerService {
    List<Uanswer> getUanswersByUserAndExam(String userId, int examId,int retake);
}
