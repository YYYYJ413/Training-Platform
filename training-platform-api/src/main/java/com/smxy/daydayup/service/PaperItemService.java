package com.smxy.daydayup.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.smxy.daydayup.pojo.ItemBank;
import com.smxy.daydayup.pojo.PaperItem;

import java.util.List;

public interface PaperItemService extends IService<PaperItem> {
    //获取试卷题目信息
    List<ItemBank> getQuestionByPaperId(int paperId);
    void removeByPaperId(int paperId);
}
