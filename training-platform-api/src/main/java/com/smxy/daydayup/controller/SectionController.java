package com.smxy.daydayup.controller;

import com.smxy.daydayup.pojo.Section;
import com.smxy.daydayup.service.Impl.SectionServiceImpl;
import com.smxy.daydayup.service.SectionService;
import com.smxy.daydayup.util.result.ResultUtil;
import com.smxy.daydayup.util.result.ReturnResult;
import com.smxy.daydayup.util.result.StatusCode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/section")
public class SectionController {

    @Autowired
    private SectionServiceImpl sectionService;

    @GetMapping("/show")
    public List<Section> getSections(@RequestParam int courseId) {
        return sectionService.getSectionsByCourseId(courseId);
    }

    @GetMapping("/maxChapterBelong/{courseId}")
    public int getMaxChapterBelong(@PathVariable int courseId) {
        return sectionService.getMaxChapterBelong(courseId);
    }

    @GetMapping("/countChapterIds/{courseId}")
    public int countChapterIds(@PathVariable int courseId) {
        return sectionService.countChapterIds(courseId);
    }

    // 新增接口，处理前端提交的章节信息
    @PostMapping("/submitSections")
    public ReturnResult submitSections(@RequestBody List<Section> sections) {
        try {
            // 调用服务层方法保存章节信息
            for (Section section : sections) {
                if(section.getChapterId()==0)
                sectionService.saveSection(section);
            }
            return ResultUtil.returnSuccess("提交成功");
        } catch (Exception e) {
            e.printStackTrace();
            return ResultUtil.returnFail(StatusCode.DATA_ERROR,"提交失败");
        }
    }

    @PutMapping("/{chapterId}")
    public ResponseEntity<Section> updateSection(@PathVariable int chapterId, @RequestBody Section section) {
        Section updatedSection = sectionService.updateSection(chapterId, section);
        return ResponseEntity.ok(updatedSection);
    }

    @DeleteMapping("/delete/{chapterId}")
    public ResponseEntity<String> deleteSection(@PathVariable int chapterId) {
        boolean isDeleted = sectionService.deleteSectionById(chapterId);
        if (isDeleted) {
            return ResponseEntity.ok("Section deleted successfully.");
        } else {
            return ResponseEntity.status(404).body("Section not found.");
        }
    }
}