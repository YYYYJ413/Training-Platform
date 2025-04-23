package com.smxy.daydayup.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.toolkit.support.SFunction;
import com.smxy.daydayup.mapper.ItemOptionMapper;
import com.smxy.daydayup.pojo.ItemBank;
import com.smxy.daydayup.pojo.ItemOption;
import com.smxy.daydayup.service.Impl.ItemBankServiceImpl;
import com.smxy.daydayup.service.Impl.ItemOptionServiceImpl;
import com.smxy.daydayup.util.enums.OptionStatusEnum;
import com.smxy.daydayup.util.enums.QuestionTypeEnum;
import com.smxy.daydayup.util.result.ResultUtil;
import com.smxy.daydayup.util.result.ReturnResult;
import com.smxy.daydayup.util.result.StatusCode;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Api(tags = "题目选项管理")
@RestController
@RequestMapping("/item-option")
public class ItemOptionController {
    @Autowired
    ItemOptionServiceImpl itemOptionService;
    @Autowired
    ItemBankServiceImpl itemBankService;
    @Autowired
    ItemOptionMapper itemOptionMapper;

    @ApiOperation("添加/更新题目选项")
    @PostMapping("/update")
    public ReturnResult update(@Validated @RequestBody ItemOption itemOption) {
        ItemBank itemBank = itemBankService.getById(itemOption.getItemId());
        if(itemBank==null){
            return ResultUtil.returnFail(400,"更新失败");
        }
        if (itemOption.getOptionId() != null) {
            LambdaUpdateWrapper<ItemOption> updateWrapper=new LambdaUpdateWrapper<>();

            Map<SFunction<ItemOption,?>,Object> map=new HashMap<>();
            map.put(ItemOption::getItemId,itemOption.getItemId());
            map.put(ItemOption::getOptionId,itemOption.getOptionId());
            updateWrapper.allEq(map);
            itemOptionService.update(itemOption,updateWrapper);
            return ResultUtil.returnSuccess("更新成功");
        }else{
            QuestionTypeEnum type=itemBank.getItemType();
            int itemMax=type.getItemMax();
            long count=itemOptionService.count(new LambdaQueryWrapper<ItemOption>().eq(ItemOption::getItemId,itemOption.getItemId()));
            if(count>=itemMax){
                return ResultUtil.returnFail(400,"添加失败，已达到选项个数上限");
            }
            itemOptionMapper.insert(itemOption);
            return ResultUtil.returnSuccess("添加成功");
        }
    }

    @ApiOperation("删除选项")
    @DeleteMapping("/delete/{optionId}")
    public ReturnResult delete(@PathVariable Integer optionId) {
        ItemOption itemOption=itemOptionService.getById(optionId);
        if(itemOption==null){
            return ResultUtil.returnFail(StatusCode.NOT_FIND_DATA,"选项Id不存在");
        }
        ItemBank itemBank=itemBankService.getById(itemOption.getItemId());
        QuestionTypeEnum type=itemBank.getItemType();
        int itemMin=type.getItemMin();
        long count=itemOptionService.count(new LambdaQueryWrapper<ItemOption>().eq(ItemOption::getItemId,itemOption.getItemId()));
        if(count<=itemMin){
            return ResultUtil.returnFail(StatusCode.DATA_ERROR,"删除失败，选项数量已为最小值");
        }
        itemOptionService.removeById(optionId);
        return ResultUtil.returnSuccess("删除成功");
    }

    @ApiOperation("更新题目正确选项")
    @PostMapping("/updateAnswer/{optionId}")
    public ReturnResult updateAnswer(@PathVariable Integer optionId){
        ItemOption option=itemOptionService.getById(optionId);
        if(option==null){
            return ResultUtil.returnFail(StatusCode.NOT_FIND_DATA,"不存在该题目");
        }
        ItemBank itemBank=itemBankService.getById(option.getItemId());
        if(itemBank==null){
            return ResultUtil.returnFail(StatusCode.NOT_FIND_DATA,"不存在该题目");
        }
        OptionStatusEnum correct=OptionStatusEnum.SELECT;
        QuestionTypeEnum questionType=itemBank.getItemType();
        ItemOption newOption=new ItemOption();
        //单选/判断先删除原选项
        if(questionType==QuestionTypeEnum.SINGLE_CHOICE||questionType==QuestionTypeEnum.JUDGEMENT){
            newOption.setOptionAnswer(null);
            LambdaUpdateWrapper<ItemOption> updateWrapper=new LambdaUpdateWrapper<>();
            updateWrapper.eq(ItemOption::getItemId,itemBank.getItemId());
            itemOptionService.update(newOption,updateWrapper);
            newOption.setOptionAnswer(correct.value);
        }else if(questionType==QuestionTypeEnum.MULTIPLE_CHOICE){
            if(option.getOptionAnswer()==null){
                newOption.setOptionAnswer(correct.value);
            }else{
                newOption.setOptionAnswer(null);
            }
        }
        newOption.setOptionId(optionId);
        itemOptionService.updateById(newOption);
        return ResultUtil.returnSuccess("题目答案更新成功");
    }

    @GetMapping("/correct/{itemId}")
    @ApiOperation(value = "根据题目ID获取正确答案")
    public List<ItemOption> getCorrectAnswers(@PathVariable Integer itemId) {
        return itemOptionService.getCorrectAnswers(itemId);
    }
}
