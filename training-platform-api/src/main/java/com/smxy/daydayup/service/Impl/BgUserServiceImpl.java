package com.smxy.daydayup.service.Impl;

import com.smxy.daydayup.mapper.BgUserMapper;
import com.smxy.daydayup.mapper.UserMapper;
import com.smxy.daydayup.pojo.User;
import com.smxy.daydayup.service.BgUserService;
import com.smxy.daydayup.util.number.EncryptionUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class BgUserServiceImpl implements BgUserService {

    @Autowired
    private BgUserMapper bguserMapper;

    @Override
    public List<User> getAllUsers() {
        return bguserMapper.selectAllUsers();
    }

    @Override
    public User addUser(User user) {
        bguserMapper.insertUser(user);
        return user; // Return the created user
    }


    @Override
    public void deleteUser(String userId) {
        bguserMapper.deleteUser(userId);
    }

    @Override
    public boolean updateUser(String userId, User user) {
        User existingUser = bguserMapper.findById(userId); // 获取现有用户信息

        if (existingUser == null) {
            return false; // 用户不存在
        }

        // 处理密码加密
        if (user.getUserPassword() != null) {
            user.setUserPassword(EncryptionUtil.md5WithSalt(user.getUserPassword()));
        } else {
            user.setUserPassword(existingUser.getUserPassword()); // 保持原有密码
        }

        // 复制其他字段
        user.setUserId(userId); // 确保设置用户 ID
        user.setTimeModify(LocalDateTime.now()); // 设置修改时间

        bguserMapper.updateUser(user);
        return true;
    }

    @Override
    public User findById(String userId) {
        return bguserMapper.findById(userId); // 查询用户
    }
}
