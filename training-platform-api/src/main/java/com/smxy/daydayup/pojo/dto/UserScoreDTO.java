package com.smxy.daydayup.pojo.dto;

import lombok.Data;

//用户考试情况
@Data
public class UserScoreDTO {
    private String userId;
    private String userName;
    private String userNumber;
    private String contactInfo;
    private String department;
    private Double highestScore;
    private int examCount;
}
