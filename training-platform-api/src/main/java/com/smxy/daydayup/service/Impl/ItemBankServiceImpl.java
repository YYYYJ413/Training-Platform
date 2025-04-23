package com.smxy.daydayup.service.Impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.smxy.daydayup.mapper.ItemBankMapper;
import com.smxy.daydayup.pojo.ItemBank;
import com.smxy.daydayup.pojo.ItemOption;
import com.smxy.daydayup.pojo.vo.ItemBankInfoVo;
import com.smxy.daydayup.service.ItemBankService;
import com.smxy.daydayup.util.enums.OptionStatusEnum;
import com.smxy.daydayup.util.enums.QuestionTypeEnum;
import lombok.extern.slf4j.Slf4j;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.ObjectUtils;

import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;

/**
 * 题目信息
 */
@Slf4j
@Service
public class ItemBankServiceImpl extends ServiceImpl<ItemBankMapper, ItemBank> implements ItemBankService {
    @Autowired
    ItemBankMapper itemBankMapper;
    @Autowired
    ItemOptionServiceImpl itemOptionService;

    /**添加题目**/
    @Override
    public String addQuestion(ItemBankInfoVo questionInfo) {
        //1.判断题目是否合法
        QuestionTypeEnum question =questionInfo.getItemType();
        if(question==null){
            log.info("题目类型不存在");
            return "题目类型不存在";
        }
        int itemMin = question.getItemMin();
        int itemMax = question.getItemMax();
        int itemSize = questionInfo.getItemOptions().size();
        if(itemSize<itemMin || itemSize>itemMax){
            log.info("题目项个数不合法"+itemSize);
            return "题目项个数不合法";
        }
        //2.单选，判断，答案只能是一个
        if(question==QuestionTypeEnum.SINGLE_CHOICE||question==QuestionTypeEnum.JUDGEMENT){
            long count = questionInfo.getItemOptions().stream().filter(el -> el.getOptionAnswer() != null).count();
            if(count!=1){
                log.info("题目正确选择个数不正确");
                return "题目正确选择个数不正确";
            }
        }
        //3.创建题目
        int result=itemBankMapper.insert((ItemBank) questionInfo);

        if(result>0){
            int itemId = questionInfo.getItemId();
            log.info(String.valueOf(itemId));
        }
//        log.info(String.valueOf(questionInfo.getItemId()));
        List<ItemOption> options = questionInfo.getItemOptions().stream().map(item->{
            item.setItemId(questionInfo.getItemId());
            if(question==QuestionTypeEnum.SINGLE_CHOICE||question==QuestionTypeEnum.JUDGEMENT ||question==QuestionTypeEnum.MULTIPLE_CHOICE){
                if(!ObjectUtils.isEmpty(item.getOptionAnswer())){
                    item.setOptionAnswer(OptionStatusEnum.SELECT.value);
                }
            }
            return item;
        }).collect(Collectors.toList());
        //4.创建选项
        itemOptionService.saveBatch(options);
        return "";
    }

    /**更新题目**/
    @Override
    public String updateQuestion(ItemBankInfoVo questionInfo){
        QuestionTypeEnum question =questionInfo.getItemType();
        if(question==null){
            return "题目类型不存在";
        }
        int itemMin = question.getItemMin();
        int itemMax = question.getItemMax();
        int itemSize = questionInfo.getItemOptions().size();
        if (itemSize < itemMin || itemSize > itemMax) {
            log.info("题目项个数不合法: " + itemSize);
            return "题目项个数不合法";
        }
        if (question == QuestionTypeEnum.SINGLE_CHOICE || question == QuestionTypeEnum.JUDGEMENT) {
            long count = questionInfo.getItemOptions().stream()
                    .filter(el -> el.getOptionAnswer() != null)
                    .count();
            if (count != 1) {
                log.info("题目正确选择个数不正确");
                return "题目正确选择个数不正确";
            }
        }
        int updateResult = itemBankMapper.updateById((ItemBank)questionInfo);
        //更新选项信息
        List<ItemOption> options = questionInfo.getItemOptions().stream().map(item -> {
            item.setItemId(questionInfo.getItemId());
            if (question == QuestionTypeEnum.SINGLE_CHOICE || question == QuestionTypeEnum.JUDGEMENT || question == QuestionTypeEnum.MULTIPLE_CHOICE) {
                if (!ObjectUtils.isEmpty(item.getOptionAnswer())) {
                    item.setOptionAnswer(OptionStatusEnum.SELECT.value);
                }
            }
            return item;
        }).collect(Collectors.toList());
        // 删除旧的选项
        itemOptionService.remove(new LambdaQueryWrapper<ItemOption>().eq(ItemOption::getItemId, questionInfo.getItemId()));
        // 保存新的选项
        itemOptionService.saveBatch(options);

        return "";
    }

    @Override
    public ItemBankInfoVo itemBankInfoVo(Integer questionId) {
        return itemBankMapper.itemBankInfo(questionId);
    }

    @Override
    public List<ItemBankInfoVo> examQuestionInfo(Integer examId) {
        return itemBankMapper.examQuestionInfo(examId);
    }

    @Override
    public List<ItemBankInfoVo> bankQuestionInfo(Integer bankId){
        return itemBankMapper.bankQuestionInfo(bankId);
    }

    public List<ItemBank> examQuestion(Integer examPaperId) {
        return itemBankMapper.examQuestion(examPaperId);
    }

    @Override
    public List<ItemBank> courseQuestion(Integer courseId){
        return itemBankMapper.courseQuestion(courseId);
    }
}
