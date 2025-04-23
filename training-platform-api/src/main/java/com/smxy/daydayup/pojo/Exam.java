package com.smxy.daydayup.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;
import org.springframework.stereotype.Component;

import javax.persistence.EntityListeners;
import javax.validation.constraints.Future;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.io.Serializable;
import java.time.LocalDateTime;

@Getter
@Setter
@ToString
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Component
@EntityListeners(AuditingEntityListener.class)
@ApiModel("考试实体类")
@TableName("sm_exams")
public class Exam implements Serializable {
    private static final long serialVersionUID = 1L;

    @TableId(value = "exam_id", type = IdType.AUTO)
    @ApiModelProperty(value = "题目ID")
    private Integer examId;

    @TableField("exam_name")
    @ApiModelProperty(value="考试标题")
    private String examName;

    @TableField("paper_id")
    @NotNull(message = "试卷id不能为空")
    @ApiModelProperty(value = "试卷ID")
    private Integer paperId;

    @TableField("course_id")
    @NotNull(message = "课程id不能为空")
    @ApiModelProperty(value = "课程ID")
    private Integer courseId;

    @TableField("retake_allowed")
    @ApiModelProperty(value="允许重考次数")
    private Integer retakeAllowed;

    @TableField("pass_mark")
    @ApiModelProperty(value="及格分数")
    private Integer passMark;

    @TableField("duration")
    @ApiModelProperty(value="考试时长")
    private Integer duration;

    @TableField("question_disorder")
    @ApiModelProperty(value="题目乱序")
    private Integer questionDisorder;

    @TableField("option_disorder")
    @ApiModelProperty(value="选项乱序")
    private Integer optionDisorder;

}
