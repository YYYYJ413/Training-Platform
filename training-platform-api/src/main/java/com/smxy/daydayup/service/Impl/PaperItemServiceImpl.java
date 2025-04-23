package com.smxy.daydayup.service.Impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.smxy.daydayup.mapper.PaperItemMapper;
import com.smxy.daydayup.pojo.ItemBank;
import com.smxy.daydayup.pojo.PaperItem;
import com.smxy.daydayup.service.PaperItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PaperItemServiceImpl extends ServiceImpl<PaperItemMapper, PaperItem> implements PaperItemService {
    @Autowired
    PaperItemMapper paperItemMapper;

    @Override
    public List<ItemBank> getQuestionByPaperId(int paperId) {
        return paperItemMapper.getQuestion(paperId);
    }
    @Override
    public void removeByPaperId(int paperId){
        paperItemMapper.removeByPaperId(paperId);
    }
}
