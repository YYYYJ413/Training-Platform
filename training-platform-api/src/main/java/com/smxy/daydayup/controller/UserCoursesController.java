package com.smxy.daydayup.controller;

import com.smxy.daydayup.pojo.UserCourses;
import com.smxy.daydayup.service.UserCoursesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/ucourse")
public class UserCoursesController {

    @Autowired
    private UserCoursesService userCoursesService;

    @GetMapping("/count/{courseId}")
    public int getUserCountByCourseId(@PathVariable int courseId) {
        return userCoursesService.countUsersByCourseId(courseId);
    }

    @GetMapping("/all")
    public List<UserCourses> getAllUserCourses() {
        return userCoursesService.findAll();
    }
}