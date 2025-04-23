package com.smxy.daydayup.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
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
 * 题库信息
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
@ApiModel("题库实体类")
@TableName("sm_bank_info")
public class BankInfo implements Serializable {
    private static final long serialVersionUID = 1L;

    @TableId(value = "bank_id", type = IdType.AUTO)
    @ApiModelProperty(value = "题库ID")
    private Integer bankId;

    @NotNull(message = "课程ID不能空~")
    @ApiModelProperty(value = "课程ID")
    private Integer courseId;

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

    @Range(min = 0, message = "题目数量不能为负数")
    @ApiModelProperty(value = "题目数量")
    private Integer itemCount;

    @ApiModelProperty(value="题库名称")
    private String bankName;
}