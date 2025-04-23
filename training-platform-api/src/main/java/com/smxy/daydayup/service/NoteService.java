package com.smxy.daydayup.service;
import com.smxy.daydayup.pojo.Note;

import java.time.LocalDateTime;
import java.util.List;

public interface NoteService {
    List<Note> getNotes(String userId, int courseId, int chapterId);
    void createNote(String userId, int courseId, int chapterId, String noteTime, String noteContent);
    boolean deleteNoteById(int noteId);
    boolean updateNoteContent(int noteId, String newContent);
}

