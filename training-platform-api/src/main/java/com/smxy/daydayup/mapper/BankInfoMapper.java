package com.smxy.daydayup.mapper;

import com.smxy.daydayup.pojo.BankInfo;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface BankInfoMapper {
    int insert(BankInfo bankInfo);
    BankInfo selectById(Integer bankId);
    List<BankInfo> selectAll();
    BankInfo selectByCourseId(Integer courseId);
    int updateById(BankInfo bankInfo);
    int deleteById(Integer bankId);
    int deleteByCourseId(Integer courseId);
}