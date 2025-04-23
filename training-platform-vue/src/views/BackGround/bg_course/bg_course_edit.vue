<template>
  <div>
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: '/HomePage' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item :to="{ path: '/bg_home/c' }">课程管理</el-breadcrumb-item>
      <el-breadcrumb-item>修改课程信息</el-breadcrumb-item>
    </el-breadcrumb>
    <el-card>
      <el-form  :model=" courseForm" label-width="120px">
        <el-form-item label="课程名称" prop="courseName">
          <el-input v-model="courseForm.courseName" placeholder="请输入课程名称"></el-input>
        </el-form-item>
        <el-form-item label="课程分类" prop="courseType">
          <el-input v-model="courseForm.courseType" placeholder="请输入课程分类"></el-input>
        </el-form-item>
        <el-form-item label="课程讲师" prop="courseTeacher">
          <el-input v-model="courseForm.courseTeacher" placeholder="请输入课程讲师"></el-input>
        </el-form-item>
        <el-form-item label="课程简介" prop="courseDesc">
          <el-input v-model="courseForm.courseDescription" placeholder="请输入课程简介"></el-input>
        </el-form-item>
        <el-form-item label="课程附件" prop="courseAttachment">
          <el-upload :action="uploadUrl" :show-file-list="false" :before-upload="beforeUpload"
                     :on-success="handleSuccess" :auto-upload="true">
            <el-button type="primary">上传文件</el-button>
          </el-upload>
          <div class="upload-tip">支持扩展名：.rar.zip.doc.docx.pdf.jpg...</div>
        </el-form-item>
      </el-form>
      <div class="section-container">
        <h3>章节信息</h3>
        <div v-for="(section, index) in sections" :key="section.chapterId" class="section-item">
          <el-form :model="section" label-width="120px">
            <el-form-item label="所属章节" prop="chapter_belong">
              <el-input v-model="section.chapterBelong" placeholder="请输入属于该课程的第几章"></el-input>
            </el-form-item>
            <el-form-item label="小节序号" prop="chapter_order">
              <el-input v-model="section.chapterOrder" placeholder="请输入属于该章节的第几小节"></el-input>
            </el-form-item>
            <el-form-item label="小节标题" prop="chapter_name">
              <el-input v-model="section.chapterName" placeholder="请输入该小节的标题"></el-input>
            </el-form-item>
            <el-form-item label="小节内容" prop="chapter_content">
              <el-input v-model="section.chapterContent" placeholder="请输入视频地址或内容"></el-input>
            </el-form-item>
            <el-button type="danger" @click="confirmRemoveSection(index)">删除</el-button>
          </el-form>
        </div>
        <el-button type="primary" @click="addSection">添加小节</el-button>
      </div>
      <div class="button-group">
        <el-button @click="goBack">取消</el-button>
        <el-button type="primary" @click="submitChanges">提交</el-button>
      </div>
    </el-card>
    <!-- 删除确认弹窗 -->
    <el-dialog title="确认删除" v-model="dialogVisible">
      <span>您确定要删除此章节吗？</span>
      <span slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" @click="removeSection">确定</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
import { ref, onMounted, watch } from 'vue';
import { ElMessage } from 'element-plus';
import axios from 'axios';
import router from "@/router/index.js";
import { useRouter } from 'vue-router';

export default {
  setup() {
    const courseForm = ref({
      courseId: null,
      courseName: '',
      courseType: '',
      courseTeacher: '',
      courseDescription: '',
      courseAttachment: ''
    });
    const sections = ref([]);
    const router = useRouter();
    const dialogVisible = ref(false);
    const sectionIndexToRemove = ref(null);

    const getCourseData = async () => {
      const courseId = router.currentRoute.value.params.course_id; // 获取传递的课程ID
      if (courseId) {
        try {
          const response = await axios.get(`http://localhost:8081/course/find?courseId=${courseId}`); // 假设的接口，需替换为实际接口
          if (response.data.code === 0) {
            const course = response.data.data;
            courseForm.value = {
              courseId: course.courseId,
              courseName: course.courseName,
              courseType: course.courseType === 0 ? '公选课' : '必选课',
              courseTeacher: course.courseTeacher,
              courseDescription: course.courseDescription,
              courseAttachment: course.courseAttachment
            };

            // console.log(courseForm.value)
            // 假设获取章节信息的接口
            const sectionsResponse = await axios.get(`http://localhost:8081/section/show?courseId=${courseId}`);
            if (sectionsResponse.data) {
              console.log(sectionsResponse.data);
              sections.value = sectionsResponse.data;

              console.log(sections.value);
            }
          }
        } catch (error) {
          console.error(error);
          ElMessage.error('获取课程信息失败');
        }
      }
    }

    onMounted(async () => {
      getCourseData();
    });
    const uploadUrl = ref('/your-upload-api-url'); // 这里需替换为实际的上传接口地址

    const goBack = () => {
      router.go(-1);
    };

    const beforeUpload = (file) => {
      // 这里可以添加文件上传前的校验逻辑，比如文件大小、类型等
      return true;
    };

    const handleSuccess = (response, file) => {
      ElMessage.success('文件上传成功');
    };

    const addSection = () => {
      sections.value.push({
        chapterBelong: '',
        chapterOrder: '',
        chapterName: '',
        chapterContent: '',
        courseId: courseForm.value.courseId,
        isNew: 6, // 标记为新小节
      });
    };

    const confirmRemoveSection = (index) => {
      sectionIndexToRemove.value = index; // 保存待删除章节的索引
      dialogVisible.value = true; // 显示确认弹窗
    };

    const removeSection = async () => {
      const chapterId = sections.value[sectionIndexToRemove.value].chapterId; // 获取章节ID
      try {
        const response = await axios.delete(`http://localhost:8081/section/delete/${chapterId}`);
        sections.value.splice(sectionIndexToRemove.value, 1); // 从数组中移除章节
        dialogVisible.value = false; // 关闭弹窗
        ElMessage.success('章节删除成功');
      } catch (error) {
        console.error(error);
        ElMessage.error('删除章节时出错');
      }
    };
    const submitChanges = async () => {
      try {
        // Construct the course update data
        const courseUpdateData = {
          courseId: courseForm.value.courseId,
          courseName: courseForm.value.courseName,
          courseType: courseForm.value.courseType === '公选课' ? 0 : 1,
          courseTeacher: courseForm.value.courseTeacher,
          courseDescription: courseForm.value.courseDescription
        };

        // Submit course information
        const response = await axios.put('http://localhost:8081/course/update', courseUpdateData);
        if (response.data.code === 0) {
          ElMessage.success('修改成功');

          // Iterate through sections to update existing ones or submit new ones
          for (const section of sections.value) {

            if (section.isNew === 6) {
              const sectionData = [];
              const newSection = {
                chapterBelong: Number(section.chapterBelong),
                chapterOrder: section.chapterOrder,
                chapterName: section.chapterName,
                chapterContent: section.chapterContent,
                courseId: section.courseId
              };
              sectionData.push(newSection);
              console.log(sectionData);
              // 提交新小节
              axios.post('http://localhost:8081/section/submitSections', sectionData)
                  .then(response => {
                    if (response.data.code === 0) {
                      ElMessage.success('提交成功');
                    } else {
                      ElMessage.error('提交失败');
                    }
                  })
                  .catch(error => {
                    console.error(error);
                    ElMessage.error('提交失败');
                  });
            } else if (section.chapterId) {

              const sectionData = {
                chapterBelong: section.chapterBelong,
                chapterContent: section.chapterContent,
                chapterId: section.chapterId,
                chapterName: section.chapterName,
                chapterOrder: section.chapterOrder,
                courseId: section.courseId,
              };

              // Update existing section
              const updateResponse = await axios.put(`http://localhost:8081/section/${section.chapterId}`, sectionData);
            }
          }
        } else {
          ElMessage.error('修改失败: ' + response.data.message);
        }
      } catch (error) {
        console.error(error);
        ElMessage.error('提交修改操作出错');
      }
    };
    // 监听课程ID的变化
    watch(() => router.currentRoute.value.params.course_id, (newCourseId, oldCourseId) => {
      if (newCourseId !== oldCourseId) {
        getCourseData(); // 当课程ID发生变化时重新获取课程数据
      }
    });
    return {
      courseForm,
      sections,
      uploadUrl,
      goBack,
      beforeUpload,
      handleSuccess,
      addSection,
      confirmRemoveSection,
      removeSection,
      submitChanges,
      dialogVisible
    };
  }
};
</script>

<style>
.form-item {
  margin-bottom: 15px;
}

.button-group {
  text-align: right;
  margin-top: 20px;
}

.upload-tip {
  color: #999;
  font-size: 12px;
}

.section-container {
  margin-top: 20px;
}

.section-item {
  border: 1px solid #e4e7ed;
  border-radius: 4px;
  padding: 15px;
  margin-bottom: 10px;
}
</style>