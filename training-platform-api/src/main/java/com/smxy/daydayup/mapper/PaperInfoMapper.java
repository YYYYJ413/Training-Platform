package com.smxy.daydayup.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.smxy.daydayup.pojo.PaperInfo;
import com.smxy.daydayup.pojo.dto.PaperInfoDetail;
import com.smxy.daydayup.pojo.vo.PaperVo;

import java.util.List;

public interface PaperInfoMapper extends BaseMapper<PaperInfo> {
    List<PaperInfoDetail> getPaperList();
}
