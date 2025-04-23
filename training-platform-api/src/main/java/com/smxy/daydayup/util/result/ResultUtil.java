package com.smxy.daydayup.util.result;

//响应接口数据工具类
public class ResultUtil {

    /**
     * 成功   不返回数据
     * @return  返回状态码和状态信息
     */
    public static ReturnResult returnSuccess(){
        ReturnResult returnResult = new ReturnResult();
        returnResult.setCode(StatusCode.SUCCESS);
        returnResult.setMessage("success");
        return  returnResult;
    }
    public static ReturnResult returnSuccess(String message){
        ReturnResult returnResult = new ReturnResult();
        returnResult.setCode(StatusCode.SUCCESS);
        if(message!=null){
            returnResult.setMessage(message);
        }else{
            returnResult.setMessage("success");
        }
        return  returnResult;
    }


    /**
     * 成功   返回数据
     * @return  返回状态码，状态信息和数据
     */
    public static ReturnResult returnSuccess(Object data,String message){
        ReturnResult returnResult = new ReturnResult();
        returnResult.setCode(StatusCode.SUCCESS);
        if(message!=null){
            returnResult.setMessage(message);
        }else{
            returnResult.setMessage("success");
        }
        returnResult.setData(data);
        return  returnResult;
    }

    /**
     * 失败
     * @return  返回状态码和状态信息
     */
    public static ReturnResult returnFail(Integer code,String message){
        ReturnResult returnResult = new ReturnResult();
        returnResult.setCode(code);
        returnResult.setMessage(message);
        return returnResult;
    }
}
