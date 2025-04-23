package com.smxy.daydayup.service.Impl;

import com.smxy.daydayup.mapper.ScoreMapper;
import com.smxy.daydayup.pojo.Score;
import com.smxy.daydayup.service.ScoreService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ScoreServiceImpl implements ScoreService {

    @Autowired
    private ScoreMapper scoreMapper;

    @Override
    public void addScore(Score score) {
        scoreMapper.insertScore(score);
    }
}

