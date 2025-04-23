package com.smxy.daydayup.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.smxy.daydayup.pojo.ItemBank;
import com.smxy.daydayup.pojo.vo.ItemBankInfoVo;
import org.apache.ibatis.annotations.Mapper;


import java.util.List;

/**
 * <p>
 * 题目信息 Mapper 接口
 * </p>
 *
 * @author baymax
 * @since 2022-10-18
 */
@Mapper
public interface ItemBankMapper extends BaseMapper<ItemBank> {
    ItemBankInfoVo itemBankInfo(Integer id);
    List<ItemBankInfoVo> examQuestionInfo(Integer examId);
    List<ItemBankInfoVo> bankQuestionInfo(Integer bankId);
    List<ItemBank> examQuestion(Integer examId);
    List<ItemBank> courseQuestion(Integer courseId);
}
