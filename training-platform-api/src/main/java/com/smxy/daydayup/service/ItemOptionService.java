package com.smxy.daydayup.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.smxy.daydayup.pojo.ItemOption;


import java.util.List;

public interface ItemOptionService extends IService<ItemOption> {

    List<ItemOption> getItemId(int itemId);
    List<ItemOption> getCorrectAnswers(Integer itemId);
}
