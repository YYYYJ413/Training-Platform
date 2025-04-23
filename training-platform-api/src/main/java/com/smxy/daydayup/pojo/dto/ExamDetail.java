package com.smxy.daydayup.pojo.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.*;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDateTime;

@Getter
@Setter
@ToString
@Builder
@AllArgsConstructor
@NoArgsConstructor
@ApiModel("考试详情实体类")
public class ExamDetail {
    @ApiModelProperty(value = "考试ID")
    private Integer examId;

    @ApiModelProperty(value = "考试名称")
    private String examName;

    @ApiModelProperty(value = "试卷ID")
    private Integer paperId;

    @ApiModelProperty(value="试卷名称")
    private String paperName;

    @ApiModelProperty(value = "课程ID")
    private Integer courseId;

    @ApiModelProperty(value = "允许重考次数")
    private Integer retakeAllowed;

    @ApiModelProperty(value = "及格分数")
    private Integer passMark;

    @ApiModelProperty(value = "考试时长")
    private Integer duration;

    @ApiModelProperty(value = "题目乱序")
    private Integer questionDisorder;

    @ApiModelProperty(value = "选项乱序")
    private Integer optionDisorder;

    @ApiModelProperty(value = "课程名称")
    private String courseName;

    @ApiModelProperty(value = "课程封面")
    private String courseCover;

    @ApiModelProperty(value = "课程简介")
    private String courseDescription;

    @ApiModelProperty(value = "课程类型")
    private Integer courseType;

    @ApiModelProperty(value = "课程教师")
    private String courseTeacher;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @ApiModelProperty(value = "创建时间")
    private LocalDateTime timeCreate;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @ApiModelProperty(value = "修改时间")
    private LocalDateTime timeModify;
}