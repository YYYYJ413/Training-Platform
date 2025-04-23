package com.smxy.daydayup.pojo.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * 自动组卷规则 VO
 */
@Data
@ApiModel(description = "自动组卷规则")
public class AutomaticPaperRuleVo {
    @ApiModelProperty(value = "试卷名称", required = true)
    private String paperName;

    @ApiModelProperty(value = "总分", required = true)
    private Integer totalScore;

    @ApiModelProperty(value = "及格分", required = true)
    private Integer passScore;

    @ApiModelProperty(value = "考试时间（分钟）", required = true)
    private Integer examTime;

    @ApiModelProperty(value = "单选题数量", required = true)
    private Integer singleNum;

    @ApiModelProperty(value = "多选题数量", required = true)
    private Integer multipleNum;

    @ApiModelProperty(value = "判断题数量", required = true)
    private Integer judgmentNum;

    @ApiModelProperty(value = "填空题数量", required = true)
    private Integer completionNum;

    @ApiModelProperty(value = "主观题数量", required = true)
    private Integer subjectiveNum;
}