package com.smxy.daydayup.util.result;

/**
 * @team daydayup
 * @time 2021-12-07 13:44
 */
//状态码静态常量类
public class StatusCode {

    //"success"
    public static final int SUCCESS = 0;

    //"服务器端异常"
    public static final int SERVER_EXCEPTION = 500100;

    //"输入参数为空"
    public static final int PARAMETER_ISNULL = 500101;

    //"用户不存在"
    public static final int USER_NOT_EXIST = 500102;

    //"不存在离线session数据"
    public static final int SESSION_NOT_EXIST = 500103;

    //"同名数据冲突"
    public static final int SAME_FAIL = 500104;

    //"查不到对应数据"
    public static final int NOT_FIND_DATA = 500105;

    //"数据格式错误"
    public static final int DATA_ERROR = 500106;
}
