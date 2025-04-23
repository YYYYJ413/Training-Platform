package com.smxy.daydayup.service.Impl;

import com.smxy.daydayup.mapper.ProgressMapper;
import com.smxy.daydayup.pojo.Progress;
import com.smxy.daydayup.service.ProgressService;
import com.smxy.daydayup.util.result.ResultUtil;
import com.smxy.daydayup.util.result.ReturnResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProgressServiceImpl implements ProgressService {

    @Autowired
    private ProgressMapper progressMapper;

    @Override
    public boolean getIsFinished(String userId, int courseId, int chapterId) {
        Boolean isFinished = progressMapper.getIsFinished(userId, courseId, chapterId);
        return isFinished != null && isFinished; // 确保返回值处理
    }

    @Override
    public Progress getProgress(String userId, int courseId, int chapterId){
        return progressMapper.getProgress(userId,courseId,chapterId);
    }

    @Override
    public List<Progress> findAll() {
        return progressMapper.findAll();
    }

    @Override
    public List<String> getFinishedChapterContents(String userId) {
        return progressMapper.getFinishedChapterContents(userId);
    }

    @Override
    public int getFinishedCount(String userId) {
        return progressMapper.getFinishedCount(userId);
    }
    //选择课程时添加
    @Override
    public ReturnResult addProgress(Progress progress) {
        progressMapper.insert(progress);
        return ResultUtil.returnSuccess("进度添加成功");
    }
    //更新完成状态
    @Override
    public ReturnResult updateProgress(Progress progress){
        progressMapper.updateById(progress);
        return ResultUtil.returnSuccess();
    }

}

