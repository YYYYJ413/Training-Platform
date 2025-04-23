package com.smxy.daydayup.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.support.SFunction;
import com.smxy.daydayup.pojo.PaperInfo;
import com.smxy.daydayup.pojo.PaperItem;
import com.smxy.daydayup.service.Impl.CourseServiceImpl;
import com.smxy.daydayup.service.Impl.ItemBankServiceImpl;
import com.smxy.daydayup.service.Impl.PaperInfoServiceImpl;
import com.smxy.daydayup.service.Impl.PaperItemServiceImpl;
import com.smxy.daydayup.util.result.ResultUtil;
import com.smxy.daydayup.util.result.ReturnResult;
import com.smxy.daydayup.util.result.StatusCode;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;

@Api(tags = "试卷题目管理")
@RestController
@RequestMapping("/paper-item")
public class PaperItemController {
    @Autowired
    PaperItemServiceImpl paperItemService;
    @Autowired
    PaperInfoServiceImpl paperInfoService;

    @Deprecated
    @ApiOperation("批量添加试卷题目")
    @PostMapping("/{paperId}/batchAdd")
    public ReturnResult batchAdd(@RequestBody Set<Integer> items, @PathVariable int paperId) {
        PaperInfo paperInfo=paperInfoService.getById(paperId);
        return ResultUtil.returnSuccess();
    }
    @Deprecated
    @ApiOperation("删除试卷题目")
    @DeleteMapping("/delete")
    public ReturnResult delete(@RequestBody PaperItem paperItem) {
        PaperInfo paperInfo=paperInfoService.getById(paperItem.getPaperId());
        if(paperInfo==null){
            return ResultUtil.returnFail(StatusCode.NOT_FIND_DATA,"题目不存在");
        }
        LambdaQueryWrapper<PaperItem> queryWrapper=new LambdaQueryWrapper<PaperItem>();
        Map<SFunction<PaperItem,?>,Object> map=new HashMap();
        map.put(PaperItem::getPaperId,paperItem.getPaperId());
        map.put(PaperItem::getItemId,paperItem.getItemId());
        queryWrapper.allEq(map);
        paperItemService.remove(queryWrapper);
        return ResultUtil.returnSuccess("删除成功");
    }
}
