package com.smxy.daydayup.pojo.vo;

import com.smxy.daydayup.pojo.ItemBank;
import com.smxy.daydayup.pojo.ItemOption;
import lombok.Data;

import java.util.ArrayList;
import java.util.List;

/**
 * 题目具体信息
 */
@Data
public class ItemBankInfoVo extends ItemBank {
    private List<ItemOption> itemOptions= new ArrayList<>();
}
