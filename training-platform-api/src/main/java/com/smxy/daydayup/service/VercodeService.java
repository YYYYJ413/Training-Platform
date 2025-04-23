package com.smxy.daydayup.service;

import com.smxy.daydayup.pojo.Vercode;

/**
* @team daydayup
* @time 2021-12-11 15:08
*/
public interface VercodeService {


int deleteByPrimaryKey(Long vercodeId);

int insert(Vercode record);

int insertSelective(Vercode record);

Vercode selectByPrimaryKey(Long vercodeId);

int updateByPrimaryKeySelective(Vercode record);

int updateByPrimaryKey(Vercode record);

Vercode selectByVercodeKey(String vercodeKey);

int updateByVercodeKey(Vercode record);
}
