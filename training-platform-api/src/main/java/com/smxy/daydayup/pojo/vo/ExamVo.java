package com.smxy.daydayup.pojo.vo;

import com.smxy.daydayup.pojo.Exam;
import com.smxy.daydayup.pojo.PaperInfo;
import lombok.Data;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;

@Data
public class ExamVo {
    @Valid
    @NotNull(message = "考试信息不能为空")
    private Exam exam;
    private PaperInfo paperInfo;
}
