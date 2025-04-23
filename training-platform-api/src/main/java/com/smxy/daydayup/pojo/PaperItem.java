package com.smxy.daydayup.pojo;

import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.*;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;
import org.springframework.stereotype.Component;

import javax.persistence.EntityListeners;
import javax.validation.constraints.NotNull;
import java.io.Serializable;

@Getter
@Setter
@ToString
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Component
@EntityListeners(AuditingEntityListener.class)
@ApiModel("试卷实体类")
@TableName("sm_papers")
public class PaperItem implements Serializable {
    private static final long serialVersionUID = 1L;

    @NotNull(message = "试卷id不能为空")
    @ApiModelProperty(value = "题目ID")
    private Integer itemId;

    @NotNull(message = "试卷id不能为空")
    @ApiModelProperty(value = "试卷ID")
    private Integer paperId;
}
