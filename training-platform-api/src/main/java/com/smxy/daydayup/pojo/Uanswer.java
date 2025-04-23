package com.smxy.daydayup.pojo;

import lombok.Data;

import java.security.Timestamp;

@Data
public class Uanswer {
    private int uexamId;
    private String userId;
    private int examId;
    private int itemId;
    private int optionId;
    private String answer;
    private Timestamp timeCreate;
    private Timestamp timeModify;
    private int retake;
    private String itemContent;
    private String itemType;
    private float itemScore;
    private String optionContent;

}
