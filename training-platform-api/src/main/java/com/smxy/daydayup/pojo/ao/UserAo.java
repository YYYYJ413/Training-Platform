package com.smxy.daydayup.pojo.ao;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.*;
import org.springframework.stereotype.Component;

/**
 * @team daydayup
 * @time 2021-12-09 14:30
 */

@Getter
@Setter
@ToString
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Component
@ApiModel("前端用户信息实体类")
public class UserAo {

    @ApiModelProperty("学号")
    private String userNumber;

    @ApiModelProperty("用户密码")
    private String userPassword;

    @ApiModelProperty("账号类型")
    private Integer typeId;
}
