package com.smxy.daydayup.pojo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.*;

import java.io.Serializable;

/**
  * @team daydayup
  * @time 2021-12-11 15:08
  */
@Getter
@Setter
@ToString
@Builder
@AllArgsConstructor
@NoArgsConstructor
@ApiModel("验证码实体类")
public class Vercode implements Serializable {
    @ApiModelProperty("验证码id")
    private Long vercodeId;

    @ApiModelProperty("验证码键")
    private String vercodeKey;

    @ApiModelProperty("验证码值")
    private String vercodeValue;

    @ApiModelProperty("时间戳")
    private Long timeStamp;

    private static final long serialVersionUID = 1L;
}