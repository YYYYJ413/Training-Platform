package com.smxy.daydayup.service;

import com.smxy.daydayup.pojo.BankInfo;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 题库信息服务接口
 */
public interface BankInfoService {
    /**
     * 插入题库信息
     * @param bankInfo 题库信息对象
     * @return 插入结果
     */
    int insert(BankInfo bankInfo);

    /**
     * 根据ID查询题库信息
     * @param bankId 题库ID
     * @return 题库信息对象
     */
    BankInfo selectById(Integer bankId);

    /**
     * 查询所有题库信息
     * @return 题库信息列表
     */
    List<BankInfo> selectAll();

    /**
     * 根据课程ID查询题库信息
     * @param courseId 课程ID
     * @return 题库信息对象
     */
    BankInfo selectByCourseId(Integer courseId);

    /**
     * 更新题库信息
     * @param bankInfo 题库信息对象
     * @return 更新结果
     */
    int updateById(BankInfo bankInfo);

    /**
     * 根据ID删除题库信息
     * @param bankId 题库ID
     * @return 删除结果
     */
    int deleteById(Integer bankId);

    /**
     * 根据课程ID删除题库信息
     * @param courseId 课程ID
     * @return 删除结果
     */
    int deleteByCourseId(Integer courseId);
}