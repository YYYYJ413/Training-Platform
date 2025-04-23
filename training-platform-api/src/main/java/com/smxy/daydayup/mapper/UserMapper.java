package com.smxy.daydayup.mapper;

import com.smxy.daydayup.pojo.User;
import com.smxy.daydayup.pojo.ao.UserAo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.time.LocalDateTime;

/**
  * @team daydayup
  * @time 2021-12-06 21:45
  */
@Mapper
public interface UserMapper {
    int deleteByPrimaryKey(String userId);

    int insert(User record);

    int insertSelective(User record);

    User selectByPrimaryKey(String userId);

    int updateByPrimaryKeySelective(User record);

    int updateByPrimaryKey(User record);

    int checkTel(@Param("userTel")String userTel);

    int checkEmail(@Param("userEmail")String userEmail);

    int checkNumber(@Param("userNumber")String userNumber,
                    @Param("schoolId")Long schoolId);

    User userLogin(UserAo userAo);

    int userRegister(@Param("userId") String userId,
                     @Param("userNumber") String userNumber,
                     @Param("userName") String userName,
                     @Param("userPassword") String userPassword,
                     @Param("userGender") int userGender,
                     @Param("typeId") int typeId,
                     @Param("timeCreate") LocalDateTime rimeCreate,
                     @Param("timeModify") LocalDateTime timeModify);

}