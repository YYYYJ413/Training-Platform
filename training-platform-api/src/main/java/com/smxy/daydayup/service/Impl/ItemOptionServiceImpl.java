package com.smxy.daydayup.service.Impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import com.smxy.daydayup.mapper.ItemOptionMapper;
import com.smxy.daydayup.pojo.ItemOption;
import com.smxy.daydayup.service.ItemOptionService;
import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.ArrayList;
import java.util.List;


@Service
public class ItemOptionServiceImpl extends ServiceImpl<ItemOptionMapper, ItemOption> implements ItemOptionService {

    @Autowired
    private ItemOptionMapper itemOptionMapper;

    @Override
    public List<ItemOption> getItemId(int itemId) {
        return list(new LambdaQueryWrapper<ItemOption>().eq(ItemOption::getItemId,itemId));
    }

    @Override
    public List<ItemOption> getCorrectAnswers(Integer itemId) {
        List<ItemOption> options = itemOptionMapper.selectByItemId(itemId);
        List<ItemOption> correctAnswers = new ArrayList<>();

        for (ItemOption option : options) {
            // Check if optionAnswer is "1"
            if ("1".equals(option.getOptionAnswer())) {
                correctAnswers.add(option);
            }
            // Check if optionAnswer is not "1" and not null
            else if (option.getOptionAnswer() != null && !"1".equals(option.getOptionAnswer())) {
                correctAnswers.add(option);
            }
        }
        return correctAnswers;
    }

}
