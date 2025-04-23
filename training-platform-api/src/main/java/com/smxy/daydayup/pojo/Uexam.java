package com.smxy.daydayup.pojo;

import lombok.Data;
import java.sql.Timestamp;

@Data
public class Uexam {
    private int uexamId;      // 学生id
    private String userId;    // 学生id，varchar(50)
    private int examId;       // 考试id
    private int itemId;       // 题目id
    private int optionId;     // 选项id
    private String answer;     // 答案
    private Timestamp timeCreate; // 创建时间
    private Timestamp timeModify; // 修改时间
    private int retake;       // 考试次数
}

