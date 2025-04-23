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
@ApiModel("课程得分实体类")
public class CourseTake implements Serializable {
    @ApiModelProperty("课程得分id")
    private Long courseScoreId;

    @ApiModelProperty("用户id(外键)")
    private String userId;

    @ApiModelProperty("课程id(外键)")
    private Long courseId;

    @ApiModelProperty("课程得分")
    private BigDecimal courseScore;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @ApiModelProperty("创建时间")
    private LocalDateTime gmtCreate;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @ApiModelProperty("修改时间")
    private LocalDateTime gmtModify;

    private static final long serialVersionUID = 1L;
}