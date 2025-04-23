package com.smxy.daydayup.mapper;

import com.smxy.daydayup.pojo.Section;
import io.swagger.models.auth.In;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface SectionMapper {
    List<Section> findSectionsByCourseId(int courseId);
    Integer findMaxChapterBelongByCourseId(@Param("courseId") int courseId);
    int countChapterIdsByCourseId(@Param("courseId") int courseId);
    void saveSection(Section section);
    void updateSection(Section section);
    Section findById(@Param("chapterId") int chapterId);
    int deleteSectionById(int chapterId);
}

