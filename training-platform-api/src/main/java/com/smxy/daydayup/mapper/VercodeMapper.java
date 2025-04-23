package com.smxy.daydayup.mapper;

import com.smxy.daydayup.pojo.Vercode;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

/**
  * @team daydayup
  * @time 2021-12-11 15:08
  */
@Mapper
public interface VercodeMapper {
    int deleteByPrimaryKey(Long vercodeId);

    int insert(Vercode record);

    int insertSelective(Vercode record);

    Vercode selectByPrimaryKey(Long vercodeId);

    int updateByPrimaryKeySelective(Vercode record);

    int updateByPrimaryKey(Vercode record);

    Vercode selectByVercodeKey(@Param("vercodeKey") String vercodeKey);

    int updateByVercodeKey(Vercode record);
}