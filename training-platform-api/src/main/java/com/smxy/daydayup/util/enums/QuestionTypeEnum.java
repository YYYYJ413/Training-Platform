package com.smxy.daydayup.util.enums;

import com.baomidou.mybatisplus.annotation.EnumValue;
import com.baomidou.mybatisplus.annotation.IEnum;
import lombok.Getter;

public enum QuestionTypeEnum implements IEnum<Integer> {
    SINGLE_CHOICE(0,"单选题", QuestionClassificationTypeEnum.OBJECTIVE,2,10),
    MULTIPLE_CHOICE(1,"多选题", QuestionClassificationTypeEnum.OBJECTIVE,2,10),
    JUDGEMENT(2,"判断题", QuestionClassificationTypeEnum.OBJECTIVE,2,2),
    COMPLETION(3,"填空题", QuestionClassificationTypeEnum.MEDIUM,1,50),
    SUBJECTIVE(4,"主观题", QuestionClassificationTypeEnum.SUBJECTIVE,1,1);
    @Getter
    @EnumValue //  Mybatis-Plus 提供注解表示插入数据库时插入该值
    private Integer value;

    @Getter
    // @JsonValue //  表示对枚举序列化时返回此字段
    private String label;
    //选择最小个数
    @Getter
    private int itemMin;
    //选项最多个数，<0不限制
    @Getter
    private int itemMax;
    @Getter
    private QuestionClassificationTypeEnum classificationType;


    QuestionTypeEnum(Integer value, String label,QuestionClassificationTypeEnum classificationType,int itemMin,int itemMax) {
        this.value = value;
        this.label = label;
        this.classificationType=classificationType;
        this.itemMin=itemMin;
        this.itemMax=itemMax;
    }
    @Override
    public Integer getValue() {
        return this.value;
    }
}
