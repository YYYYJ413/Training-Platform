package com.smxy.daydayup.service.Impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.smxy.daydayup.mapper.PaperInfoMapper;
import com.smxy.daydayup.pojo.Exam;
import com.smxy.daydayup.pojo.PaperInfo;
import com.smxy.daydayup.pojo.dto.PaperInfoDetail;
import com.smxy.daydayup.pojo.vo.PaperVo;
import com.smxy.daydayup.service.PaperInfoService;
import org.hibernate.hql.internal.ast.ParseErrorHandler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.awt.print.Paper;
import java.util.List;

@Service
public class PaperInfoServiceImpl extends ServiceImpl<PaperInfoMapper, PaperInfo> implements PaperInfoService {
    @Autowired
    PaperInfoMapper paperInfoMapper;
    public List<PaperInfoDetail> getAllPaper(){
        return paperInfoMapper.getPaperList();
    }
}
