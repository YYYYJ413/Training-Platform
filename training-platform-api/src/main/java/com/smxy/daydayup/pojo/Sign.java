package com.smxy.daydayup.pojo;

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
public class Sign implements Serializable {
    private Integer signId;

    private Long courseId;

    private Integer signNumber;

    private String userId;

    private Integer signFlag;

    private String gmtTime;

    private static final long serialVersionUID = 1L;
}