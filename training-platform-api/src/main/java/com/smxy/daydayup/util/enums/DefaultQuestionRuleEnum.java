package com.smxy.daydayup.util.enums;

import com.smxy.daydayup.util.result.ParseQuestionRules;
import lombok.Getter;

public enum DefaultQuestionRuleEnum {
    WLXP("基层卫生人员培训平台",new ParseQuestionRules("\\n\\d{1,3}\\s*[\\.、：:]","","答案：\\s*([\\s\\S]*)","；","\\n\\s*[A-Z]\\s*[、.]\\s*"));
    @Getter
    private String name;
    @Getter
    private ParseQuestionRules rule;
    DefaultQuestionRuleEnum(String name, ParseQuestionRules rule){
        this.name=name;
        this.rule=rule;
    }
}
