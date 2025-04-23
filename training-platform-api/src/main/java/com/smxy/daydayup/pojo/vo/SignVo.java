package com.smxy.daydayup.pojo.vo;

import io.swagger.annotations.ApiModel;
import lombok.*;
import org.springframework.stereotype.Component;

import java.io.Serializable;

@Getter
@Setter
@ToString
@Builder
@AllArgsConstructor
@NoArgsConstructor
@ApiModel("签到实体类")
@Component
public class SignVo implements Serializable {
    private Integer signNumber;

    private Integer signFlag;

    private String gmtTime;

    private static final long serialVersionUID = 1L;
}
