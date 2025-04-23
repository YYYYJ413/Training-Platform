package com.smxy.daydayup.pojo.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.*;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;

/**
 * @team daydayup
 * @time 2021/12/11 16:48
 */
@Getter
@Setter
@ToString
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Component
@ApiModel("课程信息实体类")
public class CourseInfo {

    @ApiModelProperty("课程id")
    private Integer courseId;

    @ApiModelProperty("课程名")
    private String courseName;

    @ApiModelProperty("课程封面")
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
