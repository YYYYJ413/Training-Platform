package com.smxy.daydayup.service;

import com.smxy.daydayup.pojo.Exam;
import com.smxy.daydayup.pojo.dto.PaperInfoDetail;
import com.smxy.daydayup.pojo.vo.PaperVo;

import java.util.List;

public interface PaperInfoService {
    List<PaperInfoDetail> getAllPaper();
}
