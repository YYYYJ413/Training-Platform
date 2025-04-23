package com.smxy.daydayup.service.Impl;

import com.smxy.daydayup.mapper.ExamMapper;
import com.smxy.daydayup.mapper.ItemMapper;
import com.smxy.daydayup.pojo.Exam;
import com.smxy.daydayup.pojo.Item;
import com.smxy.daydayup.pojo.ItemOption;
import com.smxy.daydayup.service.ItemService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@Service
public class ItemServiceImpl implements ItemService {

    private static final Logger log = LoggerFactory.getLogger(ItemServiceImpl.class);
    @Autowired
    private ItemMapper itemMapper;
    @Autowired
    private ExamMapper examMapper;
    @Autowired
    private Exam exam;

    @Override
    public List<Item> getItemsByExamId(int examId) {
        Exam exam=examMapper.selectById(examId);
        Integer questionDisorder=exam.getQuestionDisorder();
        Integer optionDisorder=exam.getOptionDisorder();


        Integer paperId = itemMapper.getPaperIdByExamId(examId);
        if (paperId == null) return new ArrayList<>();

        List<Integer> itemIds = itemMapper.getItemIdsByPaperId(paperId);
        List<Item> items = new ArrayList<>();
        for (Integer itemId : itemIds) {
            Item item = itemMapper.getItemById(itemId);
            List<ItemOption> options = itemMapper.getOptionsByItemId(itemId);
            //选项乱序
            if(optionDisorder!=null&&optionDisorder!=0){
                Collections.shuffle(options);
            }
            item.setOptions(options);
            items.add(item);
        }
        //不是0或null题目乱序
        if(questionDisorder!=null&&questionDisorder!=0){
            System.out.println(questionDisorder);
            Collections.shuffle(items);
        }
        return items;
    }
}

