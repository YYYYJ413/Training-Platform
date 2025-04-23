package com.smxy.daydayup.pojo;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class Note {
    private int noteId;       // note_id
    private String userId;       // user_id
    private int courseId;     // course_id
    private int chapterId;    // chapter_id
    private String noteContent;   // note_content
    private String noteTime; // note_time
    private LocalDateTime timeCreate; // time_create
    private LocalDateTime timeModify; // time_modify
}

