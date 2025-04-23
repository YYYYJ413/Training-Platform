package com.smxy.daydayup.service;

import com.smxy.daydayup.pojo.Item;

import java.util.List;

public interface ItemService {
    List<Item> getItemsByExamId(int examId);
}
