package com.smxy.daydayup.mapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.smxy.daydayup.pojo.Progress;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface ProgressMapper extends BaseMapper<Progress> {
    Boolean getIsFinished(String userId, int courseId, int chapterId);

    @Select("SELECT * FROM sm_progress")
    List<Progress> findAll();

    List<String> getFinishedChapterContents(String userId);

    int getFinishedCount(String userId);
    Progress getProgress(String userId, int courseId, int chapterId);
}

