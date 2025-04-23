package com.smxy.daydayup.mapper;


import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.smxy.daydayup.pojo.ItemOption;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ItemOptionMapper extends BaseMapper<ItemOption> {
    List<ItemOption> selectByItemId(Integer itemId);
}
