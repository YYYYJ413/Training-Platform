package com.smxy.daydayup.pojo;

import lombok.Data;
import java.sql.Timestamp;

@Data
public class Score {
    private int scoreId;          // 学生id
    private String userId;       // 考试id
    private int examId;          // 客观得分
    private float objectScore;    // 主观得分
    private float subjectScore;
    private float userScore;
    private int retake;
    private Timestamp timeCreate; // 创建时间
    private Timestamp timeModify; // 修改时间
}
