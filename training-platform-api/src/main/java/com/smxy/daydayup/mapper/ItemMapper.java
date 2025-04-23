package com.smxy.daydayup.mapper;

import com.smxy.daydayup.pojo.Item;
import com.smxy.daydayup.pojo.ItemOption;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ItemMapper {

    Integer getPaperIdByExamId(int examId);
    List<Integer> getItemIdsByPaperId(int paperId);
    Item getItemById(int itemId);
    List<ItemOption> getOptionsByItemId(int itemId);
}


