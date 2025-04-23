package com.smxy.daydayup.service.Impl;
import com.smxy.daydayup.mapper.NoteMapper;
import com.smxy.daydayup.pojo.Note;
import com.smxy.daydayup.service.NoteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class NoteServiceImpl implements NoteService {

    @Autowired
    private NoteMapper noteMapper;

    @Override
    public List<Note> getNotes(String userId, int courseId, int chapterId) {
        return noteMapper.getNotes(userId, courseId, chapterId);
    }

    @Override
    public void createNote(String userId, int courseId, int chapterId, String noteTime, String noteContent) {
        LocalDateTime now = LocalDateTime.now();
        noteMapper.createNote(userId, courseId, chapterId, noteTime, noteContent, now, now);
    }

    @Override
    public boolean deleteNoteById(int noteId) {
        return noteMapper.deleteNoteById(noteId) > 0;
    }

    @Override
    public boolean updateNoteContent(int noteId, String newContent) {
        return noteMapper.updateNoteContent(noteId, newContent) > 0;
    }
}
