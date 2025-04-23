package com.smxy.daydayup.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.smxy.daydayup.util.enums.QuestionTypeEnum;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.*;
import org.hibernate.validator.constraints.Range;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Component;

import javax.persistence.EntityListeners;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * <p>
 * 题目信息
 * </p>
 *
 * @author baymax
 * @since 2022-10-17
 */
@Getter
@Setter
@ToString
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Component
@EntityListeners(AuditingEntityListener.class)
@ApiModel("题目实体类")
@TableName("sm_item_bank")
public class ItemBank implements Serializable {
    private static final long serialVersionUID = 1L;

    @TableId(value = "item_id", type = IdType.AUTO)
    @ApiModelProperty(value = "题目ID")
    private Integer itemId;

    @NotBlank(message = "题目名称不能空~")
    @ApiModelProperty(value = "题目名称")
    private String itemContent;

    @NotNull(message = "题目类型不能空~")
    @ApiModelProperty(value = "题目类型：0：单选、1：多选、2：判断、3：填空、4：主观")
    private QuestionTypeEnum itemType;

//    @ApiModelProperty(value = "题目解析")
//    private String analysis;

    @Range(min = 0, max = 5, message = "题目难度应在0~5之间")
    @ApiModelProperty(value = "题目难度")
    private Integer itemDifficulty;

    @Range(min = 1, max = 100, message = "题目分值应在1~100分之间")
    @ApiModelProperty(value = "题目分值")
    private Float itemScore;

    @ApiModelProperty(value = "题库ID")
    private Integer bankId;

    @CreatedDate
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @ApiModelProperty(value = "创建时间")
    private LocalDateTime timeCreate;

    @LastModifiedDate
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @ApiModelProperty(value = "修改时间")
    private LocalDateTime timeModify;
}