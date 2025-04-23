package com.smxy.daydayup.pojo;
import lombok.Data;

@Data
public class ExamInfo {
    private int examId;
    private String examName;
    private int courseId;
    private int paperId;
    private int retakeAllowed;
    private int passMark;
    private int retake;
    private Integer questionDisorder;
    private Integer optionDisorder;
}
