package com.smxy.daydayup.service.Impl;

import com.smxy.daydayup.mapper.VercodeMapper;
import com.smxy.daydayup.pojo.Vercode;
import com.smxy.daydayup.service.VercodeService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * @team daydayup
 * @time 2021-12-11 15:06
 */
@Service
public class VercodeServiceImpl implements VercodeService {

    @Resource
    private VercodeMapper vercodeMapper;

    @Override
    public int deleteByPrimaryKey(Long vercodeId) {
        return vercodeMapper.deleteByPrimaryKey(vercodeId);
    }

    @Override
    public int insert(Vercode record) {
        return vercodeMapper.insert(record);
    }

    @Override
    public int insertSelective(Vercode record) {
        return vercodeMapper.insertSelective(record);
    }

    @Override
    public Vercode selectByPrimaryKey(Long vercodeId) {
        return vercodeMapper.selectByPrimaryKey(vercodeId);
    }

    @Override
    public int updateByPrimaryKeySelective(Vercode record) {
        return vercodeMapper.updateByPrimaryKeySelective(record);
    }

    @Override
    public int updateByPrimaryKey(Vercode record) {
        return vercodeMapper.updateByPrimaryKey(record);
    }

    @Override
    public Vercode selectByVercodeKey(String vercodeKey) {
        return vercodeMapper.selectByVercodeKey(vercodeKey);
    }

    @Override
    public int updateByVercodeKey(Vercode record) {
        return vercodeMapper.updateByVercodeKey(record);
    }


}



