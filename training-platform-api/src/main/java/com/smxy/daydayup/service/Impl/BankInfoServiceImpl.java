package com.smxy.daydayup.service.Impl;

import com.smxy.daydayup.mapper.BankInfoMapper;
import com.smxy.daydayup.pojo.BankInfo;
import com.smxy.daydayup.service.BankInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 题库信息服务实现类
 */
@Service
public class BankInfoServiceImpl implements BankInfoService {

    @Autowired
    private BankInfoMapper bankInfoMapper;

    @Override
    public int insert(BankInfo bankInfo) {
        return bankInfoMapper.insert(bankInfo);
    }

    @Override
    public BankInfo selectById(Integer bankId) {
        return bankInfoMapper.selectById(bankId);
    }

    @Override
    public List<BankInfo> selectAll() {
        return bankInfoMapper.selectAll();
    }

    @Override
    public BankInfo selectByCourseId(Integer courseId) {
        return bankInfoMapper.selectByCourseId(courseId);
    }

    @Override
    public int updateById(BankInfo bankInfo) {
        return bankInfoMapper.updateById(bankInfo);
    }

    @Override
    public int deleteById(Integer bankId) {
        return bankInfoMapper.deleteById(bankId);
    }

    @Override
    public int deleteByCourseId(Integer courseId) {
        return bankInfoMapper.deleteByCourseId(courseId);
    }
}