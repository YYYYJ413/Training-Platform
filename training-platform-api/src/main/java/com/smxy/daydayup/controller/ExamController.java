package com.smxy.daydayup.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.smxy.daydayup.pojo.Course;
import com.smxy.daydayup.pojo.Exam;
import com.smxy.daydayup.pojo.PaperInfo;
import com.smxy.daydayup.pojo.User;
import com.smxy.daydayup.pojo.vo.ExamVo;
import com.smxy.daydayup.service.Impl.CourseServiceImpl;
import com.smxy.daydayup.service.Impl.ExamServiceImpl;
import com.smxy.daydayup.service.Impl.PaperInfoServiceImpl;
import com.smxy.daydayup.service.Impl.PaperItemServiceImpl;
import com.smxy.daydayup.util.result.PageResult;
import com.smxy.daydayup.util.result.ResultUtil;
import com.smxy.daydayup.util.result.ReturnResult;
import com.smxy.daydayup.util.result.StatusCode;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Api(tags = "考试管理")
@RestController
@RequestMapping("/exam")
public class ExamController {
    @Autowired
    ExamServiceImpl examService;
    @Autowired
    PaperInfoServiceImpl paperInfoService;
    @Autowired
    PaperItemServiceImpl paperItemService;
    @Autowired
    CourseServiceImpl courseService;
    @Autowired
    private User user;

    @ApiOperation("发布考试信息")
    @PostMapping("/update")
    public ReturnResult update(@RequestBody Exam exam) {
//        Exam exam = examVo.getExam();
        if (exam == null) {
            return ResultUtil.returnFail(StatusCode.DATA_ERROR, "考试信息为空");
        }
//        System.out.println(exam);
        Course course=courseService.findCourse(exam.getCourseId());
        if(course==null){
            return ResultUtil.returnFail(StatusCode.NOT_FIND_DATA,"课程ID不存在");
        }
        examService.saveOrUpdate(exam);
        return ResultUtil.returnSuccess("考试信息更新成功");
    }

    @ApiOperation("获取指定考试信息")
    @GetMapping("/detail/{examId}")
    public ReturnResult detail(@PathVariable("examId") Integer examId) {
        Exam exam=examService.getById(examId);
        if(exam==null){
            return ResultUtil.returnFail(StatusCode.NOT_FIND_DATA,"考试ID不存在");
        }
        ExamVo examVo=new ExamVo();
        examVo.setExam(exam);
        if(paperInfoService.getById(exam.getPaperId())==null){
            return ResultUtil.returnFail(StatusCode.NOT_FIND_DATA,"试卷ID不存在");
        }
        examVo.setPaperInfo(paperInfoService.getById(exam.getPaperId()));
        return ResultUtil.returnSuccess(examVo,"获取考试信息");
    }

    @ApiOperation("获取所有考试列表")
    @GetMapping("/list")
    public ReturnResult list() {
        QueryWrapper<Exam> queryWrapper = new QueryWrapper<>();
        queryWrapper.orderByAsc("course_id");
        List<Exam> exams = examService.getAllExam();
        return ResultUtil.returnSuccess(exams, "所有考试列表");
    }

    @ApiOperation("获取我的考试信息")
    @GetMapping("/mylist/{userId}")
    public ReturnResult myList(@PathVariable("userId") String userId) {
        List<Exam> exams = examService.getMyExam(userId);
        return ResultUtil.returnSuccess(exams, "我的考试列表");
    }

    @ApiOperation("删除考试")
    @DeleteMapping("/delete/{examId}")
    public ReturnResult delete(@PathVariable("examId") Integer examId) {
        Exam exam=examService.getById(examId);
        if(exam==null){
            return ResultUtil.returnFail(StatusCode.NOT_FIND_DATA,"考试Id不存在");
        }
        examService.removeById(examId);
        return ResultUtil.returnSuccess("删除成功");
    }

    @GetMapping("/{examId}")
    public ResponseEntity<Exam> getExamById(@PathVariable Integer examId) {
        Exam exam = examService.getExamById(examId);
        if (exam != null) {
            return ResponseEntity.ok(exam);
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}
