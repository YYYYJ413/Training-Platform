package com.smxy.daydayup.pojo;

import com.baomidou.mybatisplus.annotation.*;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.*;
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
 * 题目选择表
 * </p>
 *
 * @author baymax
 * @since 2022-10-17
 */
@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Component
@EntityListeners(AuditingEntityListener.class)
@ApiModel("题目选项实体类")
@TableName("sm_item_options")
public class ItemOption {

    private static final long serialVersionUID = 1L;
    @TableId(value = "option_id", type = IdType.AUTO)
    @ApiModelProperty(value = "选项ID")
    private Integer optionId;

    @TableField("option_content")
    @ApiModelProperty(value = "选项内容\n" +
            "选择性题目：为选项\n" +
            "填空题/客观题：null\n")
    private String optionContent;

    @TableField("option_answer")
    @ApiModelProperty(value = "选项答案：\n" +
            "选择性题目：非null就是正确答案\n" +
            "填空题/客观题：为正确答案\n" )
    private String optionAnswer;

    @TableField("item_id")
    @NotNull(message = "题目ID不能空~")
    @ApiModelProperty(value = "题目ID")
    private Integer itemId;

    @TableField("time_create")
    @CreatedDate
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @ApiModelProperty(value = "创建时间")
    private LocalDateTime timeCreate;

    @TableField("time_modify")
    @LastModifiedDate
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @ApiModelProperty(value = "修改时间")
    private LocalDateTime timeModify;
}
