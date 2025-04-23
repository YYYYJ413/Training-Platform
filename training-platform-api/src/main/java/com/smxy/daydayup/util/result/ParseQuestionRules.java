package com.smxy.daydayup.util.result;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ParseQuestionRules {
    @Schema(description = "分割规则")
    private String divisionRule;

    @Schema(description = "题目规则")
    private String questionRule;

    @Schema(description = "答案规则")
    private String answerRule;

    @Schema(description = "答案分割")
    private String answerSplit;

    @Schema(description = "选择规则")
    private String optionRule;
}
