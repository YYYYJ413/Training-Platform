package com.smxy.daydayup.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.toolkit.support.SFunction;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.smxy.daydayup.pojo.Course;
import com.smxy.daydayup.pojo.ItemBank;
import com.smxy.daydayup.pojo.PaperInfo;
import com.smxy.daydayup.pojo.PaperItem;
import com.smxy.daydayup.pojo.dto.PaperInfoDetail;
import com.smxy.daydayup.pojo.vo.AutomaticPaperRuleVo;
import com.smxy.daydayup.pojo.vo.ItemBankInfoVo;
import com.smxy.daydayup.pojo.vo.PaperVo;
import com.smxy.daydayup.service.Impl.CourseServiceImpl;
import com.smxy.daydayup.service.Impl.ItemBankServiceImpl;
import com.smxy.daydayup.service.Impl.PaperInfoServiceImpl;
import com.smxy.daydayup.service.Impl.PaperItemServiceImpl;
import com.smxy.daydayup.util.enums.QuestionTypeEnum;
import com.smxy.daydayup.util.result.PageResult;
import com.smxy.daydayup.util.result.ResultUtil;
import com.smxy.daydayup.util.result.ReturnResult;
import com.smxy.daydayup.util.result.StatusCode;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiModelProperty;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.*;
import java.util.stream.Collectors;

@Api(tags = "试卷管理")
@RestController
@RequestMapping("/paper")
public class PaperInfoController {
    @Autowired
    CourseServiceImpl courseService;
    @Autowired
    PaperInfoServiceImpl paperInfoService;
    @Autowired
    PaperItemServiceImpl paperItemService;
    @Autowired
    ItemBankServiceImpl itemBankService;

    @ApiOperation("添加试卷")
    @PostMapping("/add")
    public ReturnResult add(@RequestBody @Validated PaperVo paperVo) {
//        System.out.println(paperVo.toString());
        PaperInfo paperInfo = paperVo.getPaperInfo();
        Course course = courseService.findCourse(paperInfo.getCourseId());
        if(course==null){
            return ResultUtil.returnFail(StatusCode.NOT_FIND_DATA,"课程不存在");
        }
        //保存试卷信息
        paperInfoService.save(paperInfo);
        //添加题目
        List<PaperItem> list=paperVo.getItems().stream().map(itemId -> {
            PaperItem paperItem = new PaperItem();
            paperItem.setItemId(itemId);
            paperItem.setPaperId(paperInfo.getPaperId());
            return paperItem;
        }).collect(Collectors.toList());
        paperItemService.saveBatch(list);
        return ResultUtil.returnSuccess("添加试卷成功");
    }

    @ApiOperation("更新试卷")
    @PostMapping("/update")
    public ReturnResult update(@RequestBody @Validated PaperVo paperVo){
        PaperInfo paperInfo = paperVo.getPaperInfo();
        if(paperInfo.getPaperId()==null || paperInfoService.getById(paperInfo.getPaperId())==null){
            return ResultUtil.returnFail(StatusCode.DATA_ERROR,"更新试卷时Id为空或不存在");
        }
        paperInfoService.updateById(paperInfo);
        //更新题目选项
        // 删除旧的题目关联
        paperItemService.removeByPaperId(paperInfo.getPaperId());

        // 添加新的题目关联
        List<PaperItem> list = paperVo.getItems().stream().map(itemId -> {
            PaperItem paperItem = new PaperItem();
            paperItem.setItemId(itemId);
            paperItem.setPaperId(paperInfo.getPaperId());
            return paperItem;
        }).collect(Collectors.toList());
        paperItemService.saveBatch(list);
        return ResultUtil.returnSuccess("更新成功");
    }

    @ApiOperation("删除试卷")
    @DeleteMapping("/delete/{paperId}")
    public ReturnResult delete(@PathVariable("paperId") Integer paperId) {
        if(paperInfoService.getById(paperId)==null){
            return ResultUtil.returnFail(StatusCode.DATA_ERROR,"删除失败");
        }
        paperInfoService.removeById(paperId);
        return ResultUtil.returnSuccess("删除成功");
    }

    @ApiOperation("获取试卷题目")
    @GetMapping("/detail/{paperId}")
    public ReturnResult detail(@PathVariable("paperId") Integer paperId) {
        PaperInfo paperInfo = paperInfoService.getById(paperId);
        /*PaperInfo manualQuery = paperInfoService.getBaseMapper()
                .selectOne(new LambdaQueryWrapper<PaperInfo>()
                        .eq(PaperInfo::getPaperId, paperId));
        System.out.println(manualQuery);*/
        if(paperInfo==null){
            return ResultUtil.returnFail(StatusCode.DATA_ERROR,"试卷Id不存在");
        }
        LambdaQueryWrapper<PaperItem> queryWrapper=new LambdaQueryWrapper<>();
        queryWrapper.eq(PaperItem::getPaperId,paperId);
        List<PaperItem> list=paperItemService.list(queryWrapper);
        PaperVo paperVo=new PaperVo();
        paperVo.setPaperInfo(paperInfo);
        paperVo.setItems(list.stream().map(PaperItem::getItemId).collect(Collectors.toSet()));
        return ResultUtil.returnSuccess(paperVo,"获取试卷题目成功");
    }

    @ApiOperation("试卷题目选项")
    @GetMapping("/itemDetail/{paperId}")
    public ReturnResult itemDetail(@PathVariable("paperId") Integer paperId) {
        PaperInfo paperInfo = paperInfoService.getById(paperId);
        List<ItemBankInfoVo> items=itemBankService.examQuestionInfo(paperId);
        return ResultUtil.returnSuccess(items,"获取试卷题目成功");
    }

    @ApiOperation("获取课程试卷列表")
    @GetMapping("/list/{courseId}")
    public ReturnResult list(@PathVariable("courseId") Integer courseId,
                             @RequestParam(defaultValue = "1",required = false) Integer page,
                             @RequestParam(defaultValue = "10",required = false) Integer pageSize) {
        LambdaQueryWrapper<PaperInfo> queryWrapper=new LambdaQueryWrapper<>();
        Map<SFunction<PaperInfo,?>,Object>queryMap=new HashMap<>();
        queryMap.put(PaperInfo::getCourseId,courseId);
        queryWrapper.allEq(queryMap);
        queryWrapper.orderByAsc(PaperInfo::getTimeCreate);
        Page<PaperInfo> record=paperInfoService.page(new Page<>(page,pageSize),queryWrapper);
        return ResultUtil.returnSuccess(PageResult.setResult(record),"获取试卷列表");
    }

    @ApiOperation("获取所有试卷")
    @GetMapping("/all")
    public ReturnResult all() {
        List<PaperInfoDetail> list=paperInfoService.getAllPaper();

        if(list==null||list.isEmpty()){
            return ResultUtil.returnFail(StatusCode.NOT_FIND_DATA,"没有试卷信息");
        }
        return ResultUtil.returnSuccess(list,"获取所有试卷成功");
    }

    @ApiOperation("组卷")
    @PostMapping("/{courseId}/automatic")
    public ReturnResult automaticPaper(@RequestBody AutomaticPaperRuleVo ruleVo,@PathVariable("courseId") Integer courseId) {
        List<ItemBank> itemBankList=itemBankService.courseQuestion(courseId);
        if(itemBankList==null||itemBankList.isEmpty()){
            return ResultUtil.returnFail(StatusCode.NOT_FIND_DATA, "题库为空");
        }
        PaperInfo paperInfo=new PaperInfo();
        paperInfo.setCourseId(courseId);
        paperInfo.setPaperName(ruleVo.getPaperName());
        paperInfoService.save(paperInfo);

        // 初始化试卷题目列表
        List<PaperItem> paperItemList = new ArrayList<>();
        // 随机生成题目
        Random random = new Random();
        // 单选题
        List<ItemBank> singleList = itemBankList.stream()
                .filter(item -> QuestionTypeEnum.SINGLE_CHOICE.equals(item.getItemType()))
                .collect(Collectors.toList());
//        System.out.println(singleList);
        if (singleList.size() < ruleVo.getSingleNum()) {
            paperInfoService.removeById(paperInfo.getPaperId());
            return ResultUtil.returnFail(StatusCode.DATA_ERROR, "单选题数量不足，无法生成试卷");
        }
        for (int i = 0; i < ruleVo.getSingleNum(); i++) {
            int index = random.nextInt(singleList.size());
            ItemBank item = singleList.get(index);
            PaperItem paperItem = new PaperItem();
            paperItem.setPaperId(paperInfo.getPaperId());
            paperItem.setItemId(item.getItemId());
            paperItemList.add(paperItem);
            singleList.remove(index); // 防止重复选中
        }
        // 多选题
        List<ItemBank> multipleList = itemBankList.stream()
                .filter(item -> QuestionTypeEnum.MULTIPLE_CHOICE.equals(item.getItemType()))
                .collect(Collectors.toList());
        if (multipleList.size() < ruleVo.getMultipleNum()) {
            paperInfoService.removeById(paperInfo.getPaperId());
            return ResultUtil.returnFail(StatusCode.DATA_ERROR, "多选题数量不足，无法生成试卷");
        }
        for (int i = 0; i < ruleVo.getMultipleNum(); i++) {
            int index = random.nextInt(multipleList.size());
            ItemBank item = multipleList.get(index);
            PaperItem paperItem = new PaperItem();
            paperItem.setPaperId(paperInfo.getPaperId());
            paperItem.setItemId(item.getItemId());
            paperItemList.add(paperItem);
            multipleList.remove(index); // 防止重复选中
        }
        // 判断题
        List<ItemBank> judgmentList = itemBankList.stream()
                .filter(item -> QuestionTypeEnum.JUDGEMENT.equals(item.getItemType()))
                .collect(Collectors.toList());
        if (judgmentList.size() < ruleVo.getJudgmentNum()) {
            paperInfoService.removeById(paperInfo.getPaperId());
            return ResultUtil.returnFail(StatusCode.DATA_ERROR, "判断题数量不足，无法生成试卷");
        }
        for (int i = 0; i < ruleVo.getJudgmentNum(); i++) {
            int index = random.nextInt(judgmentList.size());
            ItemBank item = judgmentList.get(index);
            PaperItem paperItem = new PaperItem();
            paperItem.setPaperId(paperInfo.getPaperId());
            paperItem.setItemId(item.getItemId());
            paperItemList.add(paperItem);
            judgmentList.remove(index); // 防止重复选中
        }
        // 填空题
        List<ItemBank> completionList = itemBankList.stream()
                .filter(item -> QuestionTypeEnum.COMPLETION.equals(item.getItemType()))
                .collect(Collectors.toList());
        if (completionList.size() < ruleVo.getCompletionNum()) {
            paperInfoService.removeById(paperInfo.getPaperId());
            return ResultUtil.returnFail(StatusCode.DATA_ERROR, "简答题数量不足，无法生成试卷");
        }
        for (int i = 0; i < ruleVo.getCompletionNum(); i++) {
            int index = random.nextInt(completionList.size());
            ItemBank item = completionList.get(index);
            PaperItem paperItem = new PaperItem();
            paperItem.setPaperId(paperInfo.getPaperId());
            paperItem.setItemId(item.getItemId());
            paperItemList.add(paperItem);
            completionList.remove(index); // 防止重复选中
        }
        //主观题
        List<ItemBank> subjectiveList = itemBankList.stream()
                .filter(item -> QuestionTypeEnum.SUBJECTIVE.equals(item.getItemType()))
                .collect(Collectors.toList());
        if (subjectiveList.size() < ruleVo.getSubjectiveNum()) {
            paperInfoService.removeById(paperInfo.getPaperId());
            return ResultUtil.returnFail(StatusCode.DATA_ERROR, "简答题数量不足，无法生成试卷");
        }
        for (int i = 0; i < ruleVo.getSubjectiveNum(); i++) {
            int index = random.nextInt(subjectiveList.size());
            ItemBank item = subjectiveList.get(index);
            PaperItem paperItem = new PaperItem();
            paperItem.setPaperId(paperInfo.getPaperId());
            paperItem.setItemId(item.getItemId());
            paperItemList.add(paperItem);
            subjectiveList.remove(index); // 防止重复选中
        }
        paperItemService.saveBatch(paperItemList);
        return ResultUtil.returnSuccess(paperItemList,"自动组卷成功");
    }

}
