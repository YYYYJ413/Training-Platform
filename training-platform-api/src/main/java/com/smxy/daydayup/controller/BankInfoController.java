package com.smxy.daydayup.controller;

import com.smxy.daydayup.pojo.BankInfo;
import com.smxy.daydayup.service.BankInfoService;
import com.smxy.daydayup.util.result.ResultUtil;
import com.smxy.daydayup.util.result.ReturnResult;
import com.smxy.daydayup.util.result.StatusCode;
import io.swagger.annotations.Api;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 题库信息控制器
 */
@RestController
@Api(tags="题库管理")
@RequestMapping("/bank")
public class BankInfoController {

    @Autowired
    private BankInfoService bankInfoService;

    /**
     * 添加题库信息
     * @param bankInfo 题库信息对象
     * @return 添加结果
     */
    @PostMapping("/add")
    public ReturnResult<String> addBankInfo(@RequestBody BankInfo bankInfo) {
        int result = bankInfoService.insert(bankInfo);
        if (result > 0) {
            return ResultUtil.returnSuccess("题库信息添加成功");
        } else {
            return ResultUtil.returnFail(StatusCode.DATA_ERROR,"题库信息添加失败");
        }
    }

    /**
     * 根据ID获取题库信息
     * @param bankId 题库ID
     * @return 题库信息对象
     */
    @GetMapping("/find/{bankId}")
    public ResponseEntity<BankInfo> getBankInfoById(@PathVariable Integer bankId) {
        BankInfo bankInfo = bankInfoService.selectById(bankId);
        if (bankInfo != null) {
            return ResponseEntity.ok(bankInfo);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    /**
     * 获取所有题库信息
     * @return 题库信息列表
     */
    @GetMapping("/all")
    public ResponseEntity<List<BankInfo>> getAllBankInfo() {
        List<BankInfo> bankInfoList = bankInfoService.selectAll();
        return ResponseEntity.ok(bankInfoList);
    }

    /**
     * 根据课程ID获取题库信息
     * @param courseId 课程ID
     * @return 题库信息对象
     */
    @GetMapping("/course/{courseId}")
    public ResponseEntity<BankInfo> getBankInfoByCourseId(@PathVariable Integer courseId) {
        BankInfo bankInfo = bankInfoService.selectByCourseId(courseId);
        if (bankInfo != null) {
            return ResponseEntity.ok(bankInfo);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    /**
     * 更新题库信息
     * @param bankInfo 题库信息对象
     * @return 更新结果
     */
    @PutMapping("/update")
    public ReturnResult updateBankInfo(@RequestBody BankInfo bankInfo) {
        int result = bankInfoService.updateById(bankInfo);
        if (result > 0) {
            return ResultUtil.returnSuccess("题库信息更新成功");
        } else {
            return ResultUtil.returnFail(StatusCode.DATA_ERROR,"题库信息更新失败");
        }
    }

    /**
     * 根据ID删除题库信息
     * @param bankId 题库ID
     * @return 删除结果
     */
    @DeleteMapping("/delete/{bankId}")
    public ReturnResult<String> deleteBankInfoById(@PathVariable Integer bankId) {
        int result = bankInfoService.deleteById(bankId);
        if (result > 0) {
            return ResultUtil.returnSuccess("题库信息删除成功");
        } else {
            return ResultUtil.returnFail(StatusCode.DATA_ERROR,"题库信息删除失败");
        }
    }

    /**
     * 根据课程ID删除题库信息
     * @param courseId 课程ID
     * @return 删除结果
     */
    @DeleteMapping("/deleteByCourse/{courseId}")
    public ResponseEntity<String> deleteBankInfoByCourseId(@PathVariable Integer courseId) {
        int result = bankInfoService.deleteByCourseId(courseId);
        if (result > 0) {
            return ResponseEntity.ok("题库信息删除成功");
        } else {
            return ResponseEntity.badRequest().body("题库信息删除失败");
        }
    }
}