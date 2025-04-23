package com.smxy.daydayup.controller;

import com.smxy.daydayup.mapper.SignMapper;
import com.smxy.daydayup.pojo.Course;
import com.smxy.daydayup.pojo.Progress;
import com.smxy.daydayup.pojo.Section;
import com.smxy.daydayup.pojo.User;
import com.smxy.daydayup.pojo.dto.StudyCourseInfo;
import com.smxy.daydayup.pojo.vo.CourseInfoPlusVO;
import com.smxy.daydayup.service.CourseService;
import com.smxy.daydayup.service.CourseTakeService;
import com.smxy.daydayup.service.Impl.CourseServiceImpl;
import com.smxy.daydayup.service.Impl.CourseTakeServiceImpl;
import com.smxy.daydayup.service.Impl.ProgressServiceImpl;
import com.smxy.daydayup.service.Impl.SectionServiceImpl;
import com.smxy.daydayup.util.datetime.DateUtil;
import com.smxy.daydayup.util.result.ResultUtil;
import com.smxy.daydayup.util.result.ReturnResult;
import com.smxy.daydayup.util.result.StatusCode;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import io.swagger.models.auth.In;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * @team daydayup
 * @time 2021/12/11 17:51
 */

@Api(tags = "课程控制器")
@RestController
@RequestMapping("/course")
public class CourseController {
    // 自动装配上需要的业务层
    @Autowired
    CourseServiceImpl courseService;
    @Autowired
    CourseTakeServiceImpl courseTakeService;
    @Autowired
    SectionServiceImpl sectionService;
    @Autowired
    ProgressServiceImpl progressService;
    @Autowired
    SignMapper signMapper;

    @ApiOperation("显示所有已学课程的接口")
    @ApiImplicitParam(
            name = "userId",
            value = "用户id",
            required = true,
            dataTypeClass = String.class
    )
    @GetMapping("/show/{userId}")    //通过用户id去查询该用户下面添加的课程
    public ReturnResult userCourse(@PathVariable("userId") String userId) {
        List<CourseInfoPlusVO> courses = courseService.selectCourse(userId);
        if(courses==null||courses.size()==0){
            return ResultUtil.returnFail(StatusCode.SERVER_EXCEPTION,"未找到学习课程");
        }
        return ResultUtil.returnSuccess(courses, "课程信息");
    }

    @ApiOperation("用户添加课程的接口")
    @ApiImplicitParam(
            name = "userId",
            value = "用户id",
            required = true,
            dataTypeClass = String.class
    )

    @PostMapping("/choose")   //通过课程id和用户id添加课程
    public ReturnResult addCourse(@RequestParam("userId")String userId,
                                  @RequestParam("courseId") Integer courseId) {
        StudyCourseInfo studyCourseInfo = new StudyCourseInfo(userId, courseId, DateUtil.getNowDate(), DateUtil.getNowDate());
        courseTakeService.insertStudyCourse(studyCourseInfo);
        List<Section> sections=sectionService.getSectionsByCourseId(courseId);
        for(Section section:sections){
            Progress progress=new Progress();
            progress.setCourseId(courseId);
            progress.setUserId(userId);
            progress.setIsFinished(0);
            progress.setChapterId(section.getChapterId());
            progressService.addProgress(progress);
        }
        return ResultUtil.returnSuccess("添加成功");
    }

    @ApiOperation("新建课程的接口")
    @ApiImplicitParams({
            @ApiImplicitParam(
                name = "courseId",
                value = "课程id",
                required = true,
                dataTypeClass = Integer.class
             ),
            @ApiImplicitParam(
                    name = "courseName",
                    value = "课程名",
                    required = true,
                    dataTypeClass = String.class
            ),
            @ApiImplicitParam(
                    name = "courseCover",
                    value = "课程封面",
                    required = true,
                    dataTypeClass = String.class
            ),

            @ApiImplicitParam(
                    name = "courseDescription",
                    value = "课程简介",
                    required = true,
                    dataTypeClass = String.class
            ),
            @ApiImplicitParam(
                    name="courseType",
                    value="课程类型",
                    required = false,
                    dataTypeClass = Integer.class
            )
    })
    @PostMapping("/new")
    public ReturnResult newCourse(@RequestParam("courseName") String courseName,
                                  @RequestParam(value = "courseCover", required = false) String courseCover,
                                  @RequestParam("courseDescription") String courseDescription,
                                  @RequestParam("courseType") int courseType,
                                  @RequestParam("courseTeacher") String courseTeacher) {
        Course course = new Course();
        course.setCourseName(courseName);
        course.setCourseCover(courseCover);
        course.setCourseDescription(courseDescription);
        course.setCourseType(courseType);
        course.setCourseTeacher(courseTeacher);
        course.setTimeCreate(DateUtil.getNowDate());
        course.setTimeModify(DateUtil.getNowDate());

        if (courseService.insert(course) > 0) {
//            System.out.println(course);
            return ResultUtil.returnSuccess(course,"课程添加成功");
        } else {
            return ResultUtil.returnFail(400, "课程添加失败");
        }


    }

    @ApiOperation("获取所有课程信息")
    @GetMapping("/showAll")  //获取所有课程信息
    public ReturnResult showAll() {
        List<Course> courses = courseService.selectAll();
//        System.out.println(courses);
        return ResultUtil.returnSuccess(courses, "所有课程信息");
    }

    @ApiOperation("获取指定课程信息")
    @GetMapping("/find")
    public ReturnResult findCourse(@RequestParam("courseId") Integer courseId) {
        Course course=courseService.findCourse(courseId);
//        System.out.println(course);
        return ResultUtil.returnSuccess(course,"指定课程信息");
    }

    @ApiOperation("删除课程")
    @ApiImplicitParam(
            name = "courseId",
            value = "课程id",
            required = true,
            dataTypeClass = String.class
    )
    @DeleteMapping("/delete")
    public ReturnResult deleteCourse(@RequestParam("courseId") String courseId) {
        if(courseService.deleteCourse(courseId)>0){
            return ResultUtil.returnSuccess("课程删除成功");
        } else{
            return ResultUtil.returnFail(400,"课程删除失败");
        }
    }

    @ApiOperation("更新课程信息")
    @PutMapping("/update")   //更新课程
    public ReturnResult updateCourse(@RequestBody Course course){
        int rows = courseService.updateByPrimaryKey(course);
        if (rows > 0) {
            Course updatedCourse = courseService.selectByPrimaryKey(course.getCourseId());
            System.out.println(updatedCourse);
            if (updatedCourse != null) {
                return ResultUtil.returnSuccess(updatedCourse,"课程更新成功");
            } else {
                return ResultUtil.returnFail(400, "课程更新后未找到相关信息");
            }
        } else {
            return ResultUtil.returnFail(400, "课程更新失败");
        }
    }

}
