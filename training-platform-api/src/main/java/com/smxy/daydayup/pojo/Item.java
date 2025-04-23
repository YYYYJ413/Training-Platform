package com.smxy.daydayup.pojo;

import java.util.List;
import lombok.Data;

@Data
public class Item {
    private int itemId;
    private String itemContent;
    private String itemType;
    private int itemDifficulty;
    private float itemScore;
    private int courseId;
    private List<ItemOption> options;

}

