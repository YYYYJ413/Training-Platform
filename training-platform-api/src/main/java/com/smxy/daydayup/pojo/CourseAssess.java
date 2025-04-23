package com.smxy.daydayup.pojo;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.*;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Component;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
  * @team daydayup
  * @time 2021-12-06 21:45
  */
@Getter
@Setter
@ToString
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Component
@ApiModel("课程评价实体类")
public class CourseAssess implements Serializable {
    @ApiModelProperty("课程评价id")
    private Long courseAssessId;

    @ApiModelProperty("课程id(外键)")
    private Long courseId;

    @ApiModelProperty("课程评价得分")
    private BigDecimal courseAssessScore;

    @ApiModelProperty("课程评价内容")
    private String courseAssessContent;

    @ApiModelProperty("用户id(外键)")
    private String userId;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @ApiModelProperty("创建时间")
    private LocalDateTime timeCreate;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @ApiModelProperty("修改时间")
    private LocalDateTime timeModify;

    private static final long serialVersionUID = 1L;
}