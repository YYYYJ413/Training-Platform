package com.smxy.daydayup.util.datetime;

import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeFormatterBuilder;
import java.time.temporal.ChronoField;
import java.util.Date;

/**
 * @team daydayup
 * @time 2021-12-08 12:56
 */



// 时间工具类
public class DateUtil {

    private static String pattern = "yyyy-MM-dd HH:mm:ss"; //日期格式

    // 获取LocalDateTime类型的系统当前时间
    public static LocalDateTime getNowDate(){
        SimpleDateFormat df = new SimpleDateFormat(pattern); //设置日期格式
        DateTimeFormatter formatter = new DateTimeFormatterBuilder().appendPattern(pattern).parseDefaulting(ChronoField.MONTH_OF_YEAR, 1)
                .parseDefaulting(ChronoField.DAY_OF_MONTH, 1).parseDefaulting(ChronoField.HOUR_OF_DAY, 0)
                .toFormatter();
        return LocalDateTime.parse(df.format(new Date()), formatter);
    }

    //
    public static LocalDateTime formatTime(String datetime){
        DateTimeFormatter df = DateTimeFormatter.ofPattern(pattern);
        LocalDateTime ldt = LocalDateTime.parse(datetime,df);
        return ldt;
    }
}
