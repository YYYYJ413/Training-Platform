package com.smxy.daydayup.controller;
import com.smxy.daydayup.pojo.Note;
import com.smxy.daydayup.service.NoteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;

@RestController
@RequestMapping("/notes")
public class NoteController {

    @Autowired
    private NoteService noteService;

    @GetMapping("/show")
    public List<Note> getNotes(@RequestParam String userId, @RequestParam int courseId, @RequestParam int chapterId) {
        return noteService.getNotes(userId, courseId, chapterId);
    }

    @PostMapping
    public void createNote(@RequestParam String userId, @RequestParam int courseId,
                           @RequestParam int chapterId, @RequestParam String noteTime,
                           @RequestParam String noteContent) {
        noteService.createNote(userId, courseId, chapterId, noteTime, noteContent);
    }

    // 删除笔记
    @DeleteMapping("/{noteId}")
    public String deleteNote(@PathVariable int noteId) {
        boolean isDeleted = noteService.deleteNoteById(noteId);
        return isDeleted ? "Note deleted successfully." : "Note not found.";
    }

    // 编辑笔记内容
    @PutMapping("/{noteId}")
    public String updateNoteContent(@PathVariable int noteId, @RequestBody String newContent) {
        boolean isUpdated = noteService.updateNoteContent(noteId, newContent);
        return isUpdated ? "Note updated successfully." : "Note not found.";
    }
}
