package com.smxy.daydayup.service.Impl;

import com.smxy.daydayup.mapper.UanswerMapper;
import com.smxy.daydayup.pojo.Uanswer;
import com.smxy.daydayup.service.UanswerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UanswerServiceImpl implements UanswerService {

    @Autowired
    private UanswerMapper uanswerMapper;


    @Override
    public List<Uanswer> getUanswersByUserAndExam(String userId, int examId,int retake) {
        return uanswerMapper.getUanswersByUserAndExam(userId, examId,retake);
    }
}