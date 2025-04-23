package com.smxy.daydayup.mapper;

import com.smxy.daydayup.pojo.User;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface BgUserMapper extends BaseMapper<User> {
    List<User> selectAllUsers();
    int insertUser(User user);
    int deleteUser(@Param("userId") String userId);
    int updateUser(User user);
    User findById(@Param("userId") String userId);
}

