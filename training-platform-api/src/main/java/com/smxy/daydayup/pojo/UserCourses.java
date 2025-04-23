package com.smxy.daydayup.pojo;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UserCourses {
    private String userId;
    private int courseId;
    private LocalDateTime timeCreate;
    private LocalDateTime timeModify;
}

