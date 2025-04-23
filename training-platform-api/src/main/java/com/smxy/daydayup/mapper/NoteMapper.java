package com.smxy.daydayup.mapper;
import com.smxy.daydayup.pojo.Note;
import org.apache.ibatis.annotations.*;

import java.time.LocalDateTime;
import java.util.List;

@Mapper
public interface NoteMapper {
    List<Note> getNotes(@Param("userId") String userId, @Param("courseId") int courseId, @Param("chapterId") int chapterId);

    void createNote(@Param("userId") String userId, @Param("courseId") int courseId,
                    @Param("chapterId") int chapterId, @Param("noteTime") String noteTime,
                    @Param("noteContent") String noteContent,
                    @Param("timeCreate") LocalDateTime timeCreate, @Param("timeModify") LocalDateTime timeModify);

    int deleteNoteById(@Param("noteId") int noteId);

    int updateNoteContent(@Param("noteId") int noteId, @Param("newContent") String newContent);
}

