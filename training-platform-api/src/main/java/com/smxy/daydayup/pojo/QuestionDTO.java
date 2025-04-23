package com.smxy.daydayup.pojo;

import lombok.Data;

import java.util.Date;

@Data
public class QuestionDTO {
    private int questionId;          // question_id
    private String userId;           // user_id
    private String userName;         // user_name
    private int courseId;            // course_id
    private String courseName;       // course_name
    private String questionContent;   // question_content
    private String questionAnswer;    // question_answer
    private boolean isSolve;          // is_solve
    private Date askTime;             // ask_time
    private Date answerTime;          // answer_time
    private Date timeCreate;          // time_create
    private Date timeModify;          // time_modify
}

