package com.smxy.daydayup.mapper;

import com.smxy.daydayup.pojo.Score;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ScoreMapper {

    void insertScore(Score score);
}

