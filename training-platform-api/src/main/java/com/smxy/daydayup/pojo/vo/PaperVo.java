package com.smxy.daydayup.pojo.vo;

import com.smxy.daydayup.pojo.PaperInfo;
import io.swagger.models.auth.In;
import lombok.Data;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import java.util.Set;

@Data
public class PaperVo{
    @Valid
    PaperInfo paperInfo;
    Set<Integer> items;
}
