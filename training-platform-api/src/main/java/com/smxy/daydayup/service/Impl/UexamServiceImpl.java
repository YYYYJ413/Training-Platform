package com.smxy.daydayup.service.Impl;

import com.smxy.daydayup.mapper.UexamMapper;
import com.smxy.daydayup.pojo.Uexam;
import com.smxy.daydayup.service.UexamService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UexamServiceImpl implements UexamService {

    @Autowired
    private UexamMapper uexamMapper;

    @Override
    public void addUexam(Uexam uexam) {
        uexamMapper.insertUexam(uexam);
    }
}

