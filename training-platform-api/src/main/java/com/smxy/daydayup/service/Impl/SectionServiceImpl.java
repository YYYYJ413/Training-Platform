package com.smxy.daydayup.service.Impl;

import com.smxy.daydayup.mapper.SectionMapper;
import com.smxy.daydayup.pojo.Section;
import com.smxy.daydayup.service.SectionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SectionServiceImpl implements SectionService {

    @Autowired
    private SectionMapper sectionMapper;

    @Override
    public List<Section> getSectionsByCourseId(int courseId) {
        return sectionMapper.findSectionsByCourseId(courseId);
    }

    @Override
    public Integer getMaxChapterBelong(int courseId) {
        return sectionMapper.findMaxChapterBelongByCourseId(courseId);
    }

    @Override
    public int countChapterIds(int courseId) {
        return sectionMapper.countChapterIdsByCourseId(courseId);
    }

    @Override
    public void saveSection(Section section) {
        sectionMapper.saveSection(section);
    }

    @Override
    public Section updateSection(int chapterId, Section section) {
        section.setChapterId(chapterId);
        sectionMapper.updateSection(section);
        return sectionMapper.findById(chapterId);
    }

    @Override
    public boolean deleteSectionById(int chapterId) {
        return sectionMapper.deleteSectionById(chapterId) > 0;
    }
}

