package com.smxy.daydayup.util.enums;

import cn.hutool.core.util.ObjectUtil;
import java.util.EnumSet;
import java.util.Objects;

public interface BaseEnum<T> {

    T getValue();

    String getLabel();

    static <E extends Enum<E> & BaseEnum> E getEnumByValue(Object value, Class<E> clazz) {
        Objects.requireNonNull(value);
        EnumSet<E> allEnums = EnumSet.allOf(clazz); // 获取类型下的所有枚举
        E matchEnum = allEnums.stream()
                .filter(e -> {
                    boolean equal =ObjectUtil.equal(e.getValue().toString(),value);
                    System.out.println(equal+"..."+value+"..."+e.getValue());
                    return equal;
                })
                .findFirst()
                .orElse(null);
        return matchEnum;
    }

    static <E extends Enum<E> & BaseEnum> String getLabelByValue(Object value, Class<E> clazz) {
        Objects.requireNonNull(value);
        EnumSet<E> allEnums = EnumSet.allOf(clazz); // 获取类型下的所有枚举
        E matchEnum = allEnums.stream()
                .filter(e -> ObjectUtil.equal(e.getValue(), value))
                .findFirst()
                .orElse(null);

        String label = null;
        if (matchEnum != null) {
            label = matchEnum.getLabel();
        }
        return label;
    }

    static <E extends Enum<E> & BaseEnum> Object getValueByLabel(String label, Class<E> clazz) {
        Objects.requireNonNull(label);
        EnumSet<E> allEnums = EnumSet.allOf(clazz); // 获取类型下的所有枚举
        String finalLabel = label;
        E matchEnum = allEnums.stream()
                .filter(e -> ObjectUtil.equal(e.getLabel(), finalLabel))
                .findFirst()
                .orElse(null);

        Object value = null;
        if (matchEnum != null) {
            value = matchEnum.getValue();
        }
        return value;
    }


}
