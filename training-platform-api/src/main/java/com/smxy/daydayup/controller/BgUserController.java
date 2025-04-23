package com.smxy.daydayup.controller;

import com.smxy.daydayup.pojo.User;
import com.smxy.daydayup.service.BgUserService;
import com.smxy.daydayup.util.IdUtil;
import com.smxy.daydayup.util.number.EncryptionUtil;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/bg/users")
@Api(tags = "用户管理")
public class BgUserController {

    @Autowired
    private BgUserService bgUserService;

    @PostMapping
    public ResponseEntity<User> addUser(@RequestBody User user) {
        // Generate UUID for userId
        user.setUserId(IdUtil.getUUID());

        // Encrypt the user password
        String encryptedPassword = EncryptionUtil.md5WithSalt(user.getUserPassword());
        user.setUserPassword(encryptedPassword);

        User createdUser = bgUserService.addUser(user);
        return ResponseEntity.ok(createdUser);
    }

    @DeleteMapping("/{userId}")
    @ApiOperation("删除用户")
    public ResponseEntity<Void> deleteUser(@PathVariable String userId) {
        bgUserService.deleteUser(userId);
        return ResponseEntity.noContent().build();
    }

    @GetMapping
    @ApiOperation("获取所有用户")
    public List<User> getAllUsers() {
        return bgUserService.getAllUsers();
    }

    // 更新用户信息
    @PutMapping("/{userId}")
    public ResponseEntity<String> updateUser(@PathVariable String userId, @RequestBody User user) {
        boolean isUpdated = bgUserService.updateUser(userId, user);
        return isUpdated ? ResponseEntity.ok("User updated successfully") : ResponseEntity.notFound().build();
    }

    // 根据 ID 获取用户信息
    @GetMapping("/{userId}")
    public ResponseEntity<User> getUserById(@PathVariable String userId) {
        User user = bgUserService.findById(userId);
        return user != null ? ResponseEntity.ok(user) : ResponseEntity.notFound().build();
    }
}
