package com.smxy.daydayup.service;

import com.smxy.daydayup.pojo.User;
import com.smxy.daydayup.pojo.ao.UserAo;

/**
  * @team daydayup
  * @time 2021-12-06 21:45
  */
public interface UserService {


    int deleteByPrimaryKey(String userId);

    int insert(User record);

    int insertSelective(User record);

    User selectByPrimaryKey(String userId);

    int updateByPrimaryKeySelective(User record);

    int updateByPrimaryKey(User record);

    // 效验学号
    int checkNumber(String userNumber,
                    Long schoolId);

    // 效验手机号
    int checkTel(String userTel);

    // 用户登录
    User userLogin(UserAo record);

    // 用户信息注册(完善必要信息)
//    String userInfoRegister(User record);

    // 用户注册(添加用户)
    String userRegister(String userNumber,
                        String userName,String userPassword,int userGender);
}
