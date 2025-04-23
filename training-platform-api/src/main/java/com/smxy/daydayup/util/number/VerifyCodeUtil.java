package com.smxy.daydayup.util.number;

import java.security.SecureRandom;
import java.util.Random;

/**
 * @team daydayup
 * @time 2021-12-09 15:59
 */
// 验证码工具类
public class VerifyCodeUtil {

    private static final String SYMBOLS = "0123456789ABCDEFGHIGKLMNOPQRSTUVWXYZ";
    private static final Random RANDOM = new SecureRandom(); //安全随机数

    // 生成 4 位数的随机数字
    public static String generateCode() {
        // 大小为 4 的数组作为容器
        char[] numbers = new char[4];
        for (int i = 0; i < numbers.length; i++) {
            numbers[i] = SYMBOLS.charAt(RANDOM.nextInt(SYMBOLS.length()));
        }
        return new String(numbers);
    }

    // 生成指定位数的随机数字
    public static String generateCode(int n) {
        char[] numbers = new char[n];
        for (int i = 0; i < numbers.length; i++) {
            numbers[i] = SYMBOLS.charAt(RANDOM.nextInt(SYMBOLS.length()));
        }
        return new String(numbers);
    }

}
