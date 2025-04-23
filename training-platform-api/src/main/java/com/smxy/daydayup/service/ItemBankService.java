package com.smxy.daydayup.service;

import com.smxy.daydayup.pojo.ItemBank;
import com.smxy.daydayup.pojo.vo.ItemBankInfoVo;
import com.smxy.daydayup.util.enums.QuestionTypeEnum;
import java.util.Collection;
import java.util.List;

public interface ItemBankService {

    String addQuestion(ItemBankInfoVo questionInfo);
    String updateQuestion(ItemBankInfoVo questionInfo);
    ItemBankInfoVo itemBankInfoVo(Integer questionId);
    List<ItemBankInfoVo> examQuestionInfo(Integer examId);
//    List<ItemBank> getQuestionsByTags(int userId, int courseId, Collection<Integer> tagList, Collection<QuestionTypeEnum> typeList);
    List<ItemBankInfoVo> bankQuestionInfo(Integer bankId);
    List<ItemBank> courseQuestion(Integer courseId);
}
