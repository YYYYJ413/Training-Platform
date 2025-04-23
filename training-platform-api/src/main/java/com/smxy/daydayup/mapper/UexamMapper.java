package com.smxy.daydayup.mapper;

import com.smxy.daydayup.pojo.Uexam;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UexamMapper {

    void insertUexam(Uexam uexam);
}
