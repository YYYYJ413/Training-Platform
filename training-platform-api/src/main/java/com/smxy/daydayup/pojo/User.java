package com.smxy.daydayup.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.*;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Component;

import javax.persistence.Table;
import java.io.Serializable;
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
@ApiModel("用户实体类")
@Table(schema = "sm_users")
public class User implements Serializable {

    @TableId(value = "user_id", type = IdType.AUTO)
    @ApiModelProperty(value = "用户id")
    private String userId;

    @ApiModelProperty(value = "用户名")
    private String userName;

    @ApiModelProperty(value = "用户编号")
    private String userNumber;

    @ApiModelProperty(value = "用户电话")
    private String contactInfo;

    @ApiModelProperty(value = "用户密码")
    private String userPassword;

    @ApiModelProperty(value = "用户类型ID")
    private Integer typeId;

    @ApiModelProperty(value = "性别")
    private Integer userGender;

    @ApiModelProperty(value = "用户头像")
    private String userImg;

    @ApiModelProperty(value = "部门")
    private String department;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @ApiModelProperty(value = "创建时间")
    private LocalDateTime timeCreate;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @ApiModelProperty(value = "修改时间")
    private LocalDateTime timeModify;

    private String ddToken;

    private static final long serialVersionUID = 1L;
}