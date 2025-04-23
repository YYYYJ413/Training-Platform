package com.smxy.daydayup.pojo;
import lombok.Data;

import javax.persistence.Column;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
public class Assess {
    private int assessId;          // assess_id
    private int courseId;          // course_id
    @Column(length = 4, scale = 2)
    private BigDecimal assessScore; // assess_score
    private String assessContent;   // assess_content
    private String userId;          // user_id
    private LocalDateTime timeCreate; // time_create
    private LocalDateTime timeModify; // time_modify
}

