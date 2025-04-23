package com.smxy.daydayup.service;

import com.smxy.daydayup.pojo.Section;

import java.util.List;

public interface SectionService {
    List<Section> getSectionsByCourseId(int courseId);
    Integer getMaxChapterBelong(int courseId);
    int countChapterIds(int courseId);
    void saveSection(Section section);
    Section updateSection(int chapterId, Section section);
    boolean deleteSectionById(int chapterId);
}

