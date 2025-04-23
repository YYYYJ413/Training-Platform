package com.smxy.daydayup.controller;

import com.smxy.daydayup.pojo.Item;
import com.smxy.daydayup.service.ItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/items")
public class ItemController {

    @Autowired
    private ItemService itemService;

    @GetMapping("/{examId}")
    public List<Item> getItemsByExamId(@PathVariable int examId) {
        return itemService.getItemsByExamId(examId);
    }
}
