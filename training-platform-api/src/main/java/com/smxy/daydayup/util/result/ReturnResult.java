package com.smxy.daydayup.util.result;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

/**
 * @team daydayup
 * @time 2021-12-07 13:39
 */
@Data
@ApiModel("接口响应数据类")
public class ReturnResult<T> implements Serializable {

    @ApiModelProperty("状态码")
    private Integer code;
    @ApiModelProperty("提示信息")
    private String message;
    @ApiModelProperty("返回数据")
    private T data;

}
