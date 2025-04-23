package com.smxy.daydayup.service.Impl;

import com.smxy.daydayup.mapper.CourseMapper;
import com.smxy.daydayup.mapper.UserMapper;
import com.smxy.daydayup.pojo.Course;
import com.smxy.daydayup.pojo.User;
import com.smxy.daydayup.pojo.vo.CourseInfoPlusVO;
import com.smxy.daydayup.pojo.vo.CoursePlusVO;
import com.smxy.daydayup.service.CourseService;
import com.smxy.daydayup.util.JwtUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class CourseServiceImpl implements CourseService{

    @Resource
    private CourseMapper courseMapper;
    @Resource
    private UserMapper userMapper;
    @Override
    public int deleteCourse(String courseId) {
        return courseMapper.deleteCourse(courseId);
    }

    @Override
    public int insert(Course record) {
        return courseMapper.insert(record);
    }

    @Override
    public int insertSelective(Course record) {
        return courseMapper.insertSelective(record);
    }

    @Override
    public Course findCourse(Integer courseId) {
        return courseMapper.findCourse(courseId);
    }

    @Override
    public int updateByPrimaryKeySelective(Course record) {
        return courseMapper.updateByPrimaryKeySelective(record);
    }

    @Override
    public int updateByPrimaryKey(Course record) {
        return courseMapper.updateByPrimaryKey(record);
    }

    //用户学习的课程
    @Override
    public List<CourseInfoPlusVO> selectCourse(String userId) {
        User user = userMapper.selectByPrimaryKey(userId);
        List<Course> courseInfos = courseMapper.selectCourse(userId);
        System.out.println("finding courses of "+userId+' '+courseInfos.size());
        return courseInfos.stream().map(c -> {

            CourseInfoPlusVO coursePlusVO = new CourseInfoPlusVO();
            BeanUtils.copyProperties(c, coursePlusVO);
            coursePlusVO.setJwt(JwtUtils.createZFToken(user, c.getCourseId(), false));
            return coursePlusVO;
        }).collect(Collectors.toList());
    }

    @Override
    public List<CoursePlusVO> selectprofessorCourse(String userId) {
        List<Course> courses = courseMapper.selectprofessorCourse(userId);

        User user = userMapper.selectByPrimaryKey(userId);

        return courses.stream().map(c -> {

            CoursePlusVO coursePlusVO = new CoursePlusVO();
            BeanUtils.copyProperties(c, coursePlusVO);

            coursePlusVO.setJwt(JwtUtils.createZFToken(user, c.getCourseId(), true));

            return coursePlusVO;
        }).collect(Collectors.toList());
    }

    @Override
    public Course selectByPrimaryKey(Integer courseId){
        return courseMapper.selectByPrimaryKey(courseId);
    }

    @Override
    public List<Course> selectAll() {
        return courseMapper.selectAll();
    }
}
