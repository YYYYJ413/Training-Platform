package com.smxy.daydayup.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.support.SFunction;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.smxy.daydayup.pojo.BankInfo;
import com.smxy.daydayup.pojo.Course;
import com.smxy.daydayup.pojo.ItemBank;
import com.smxy.daydayup.pojo.vo.ItemBankInfoVo;
import com.smxy.daydayup.service.Impl.BankInfoServiceImpl;
import com.smxy.daydayup.service.Impl.CourseServiceImpl;
import com.smxy.daydayup.service.Impl.ItemBankServiceImpl;
import com.smxy.daydayup.util.enums.DefaultQuestionRuleEnum;
import com.smxy.daydayup.util.result.PageResult;
import com.smxy.daydayup.util.result.ResultUtil;
import com.smxy.daydayup.util.result.ReturnResult;
import com.smxy.daydayup.util.result.StatusCode;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.v3.oas.annotations.Operation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Api(tags = "题目管理")
@RestController
@RequestMapping("/item-bank")
public class ItemBankController {
    @Autowired
    ItemBankServiceImpl itemBankService;
    @Autowired
    CourseServiceImpl courseService;
    @Autowired
    BankInfoServiceImpl bankInfoService;

    @ApiOperation("获取题库题目列表")
    @GetMapping("/getList/{bankId}")
    public ReturnResult getList(@PathVariable int bankId) {
        BankInfo bankInfo=bankInfoService.selectById(bankId);
        if(bankInfo==null){
            return ResultUtil.returnFail(StatusCode.NOT_FIND_DATA,"题库Id不存在");
        }
        List<ItemBankInfoVo> items=itemBankService.bankQuestionInfo(bankId);
        LambdaQueryWrapper<ItemBank> queryWrapper=new LambdaQueryWrapper<ItemBank>();
        Map<SFunction<ItemBank,?>,Object> map=new HashMap<>();
        map.put(ItemBank::getBankId,bankId);
        queryWrapper.allEq(map).orderByAsc(ItemBank::getItemType);
        List<ItemBank> list=itemBankService.list(queryWrapper);
        return ResultUtil.returnSuccess(items,"获取题库题目成功");
    }

    @ApiOperation("创建题目")
    @PostMapping("/add")
    public ReturnResult add(@RequestBody @Validated ItemBankInfoVo questionInfo) {
        String result=itemBankService.addQuestion(questionInfo);
        if("".equals(result)){
            return ResultUtil.returnSuccess("题目创建成功");
        }else{
            return ResultUtil.returnFail(400,"题目创建失败");
        }
    }

    @ApiOperation("更新题目")
    @PostMapping("/update")
    public ReturnResult update(@RequestBody @Validated ItemBankInfoVo question) {
        if(question.getItemId()==null ||itemBankService.getById(question.getItemId())==null){
            return ResultUtil.returnFail(StatusCode.NOT_FIND_DATA,"题目不存在");
        }
        String result=itemBankService.updateQuestion(question);
        if("".equals(result)){
            return ResultUtil.returnSuccess("题目更新成功");
        }else{
            return ResultUtil.returnFail(400,"题目更新失败");
        }
    }

    @ApiOperation("删除题目")
    @DeleteMapping("/delete/{itemId}")
    public ReturnResult delete(@PathVariable("itemId") Integer itemId) {
        ItemBank item = itemBankService.getById(itemId);
        if(item==null){
            return ResultUtil.returnFail(StatusCode.NOT_FIND_DATA,"题目Id不存在");
        }
        itemBankService.removeById(itemId);
        return ResultUtil.returnSuccess("删除成功");
    }

    @ApiOperation("题目详情")
    @GetMapping("/detail/{itemId}")
    public ReturnResult detail(@PathVariable("itemId") Integer itemId) {
        ItemBank item = itemBankService.getById(itemId);
        if(item==null){
            return ResultUtil.returnFail(StatusCode.NOT_FIND_DATA,"题目Id不存在");
        }
        ItemBankInfoVo itemInfo=itemBankService.itemBankInfoVo(itemId);
        return ResultUtil.returnSuccess(itemInfo,"题目详情");
    }

    @Operation(summary = "获取匹配题目规则")
    @GetMapping("/rules")
    public ReturnResult rules(){
        Map<String, String> collect = Arrays.stream(DefaultQuestionRuleEnum.values()).collect(Collectors.toMap(DefaultQuestionRuleEnum::name, DefaultQuestionRuleEnum::getName));
        return ResultUtil.returnSuccess(collect,"题目匹配规则");
    }
}
