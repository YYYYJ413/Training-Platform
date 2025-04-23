package com.smxy.daydayup.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.smxy.daydayup.pojo.ItemBank;
import com.smxy.daydayup.pojo.PaperItem;

import java.util.List;

public interface PaperItemMapper extends BaseMapper<PaperItem> {
    List<ItemBank> getQuestion(Integer paperId);
    void removeByPaperId(Integer paperId);
}
