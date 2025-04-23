<template>
  <div>
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: '/HomePage' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item :to="{ path: '/bg_home/c' }">课程管理</el-breadcrumb-item>
      <el-breadcrumb-item>添加课程</el-breadcrumb-item>
    </el-breadcrumb>
    <el-card>
      <form ref="formRef" label-width="120px">
        <el-form-item label="课程名称">
          <el-input v-model="courseForm.courseName" placeholder="请输入课程名称" style="width: 50%;"></el-input>
        </el-form-item>
        <el-form-item label="课程分类">
          <el-select v-model="courseForm.courseType" placeholder="请选择课程分类" style="width: 50%;">
            <el-option label="公选课" :value="1"></el-option>
            <el-option label="必选课" :value="2"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="课程讲师">
          <el-input v-model="courseForm.courseTeacher" placeholder="请输入讲师" style="width: 50%;"></el-input>
        </el-form-item>
        <el-form-item label="课程简介">
          <el-input v-model="courseForm.courseDescription" placeholder="请输入内容" style="width: 50%;"></el-input>
        </el-form-item>
        <el-form-item label="课程封面">
          <el-upload :action="uploadUrl" :show-file-list="false" :before-upload="beforeUpload"
            :on-success="handleSuccess" :auto-upload="true">
            <el-button type="primary">上传文件</el-button>
          </el-upload>
          <div class="upload-tip">支持扩展名：pdf.jpg</div>
        </el-form-item>
      </form>
      <div class="button-group">
        <el-button @click="goBack">取消</el-button>
        <el-button type="primary" @click="submitForm">下一步</el-button>
      </div>
    </el-card>
  </div>
</template>

<script>
import { reactive } from 'vue';
import { ElMessage } from 'element-plus';
import axios from 'axios';
import { useRouter } from "vue-router";
import { addCourse } from '../../../api';

export default {
  setup() {
    const courseForm = reactive({
      courseName: '',
      courseType: null,
      courseTeacher: '',
      courseDescription: '',
      courseAttachment: 'https://tse1-mm.cn.bing.net/th/id/OIP-C.LSzuSVzYZ6-tBsN2i03t1gHaEH?rs=1&pid=ImgDetMain'
    });
    const router = useRouter();
    const uploadUrl = '/your-upload-api-url'; // 替换为实际的上传接口地址

    const goBack = () => {
      router.push({ path: 'c' });
    };

    const beforeUpload = (file) => {
      return true;
    };

    const handleSuccess = (response, file) => {
      ElMessage.success('文件上传成功');
      courseForm.courseAttachment = response.url; // 假设响应中包含 URL
    };

    const submitForm = async () => {
      // 确保表单数据有效
      if (!courseForm.courseName) {
        ElMessage.error('课程名称不能为空');
        return;
      }

      try {
        const response = await addCourse(courseForm.courseName, courseForm.courseAttachment, courseForm.courseDescription, courseForm.courseType, courseForm.courseTeacher);
        console.log(response.data);
        if (response.data.code == 0) {
          ElMessage.success('课程添加成功');
          const courseId = response.data.data.courseId; // 假设响应中包含 courseId
          // 将 courseId 存储到路由状态中
          router.push({ path: '/bg_home/sectionAdd', query: { courseId } });
          // 清空表单
          Object.keys(courseForm).forEach(key => courseForm[key] = '');
        } else {
          ElMessage.error('课程添加失败');
        }
      } catch (error) {
        console.error(error);
        ElMessage.error('提交课程数据出错');
      }
    };


    return {
      courseForm,
      uploadUrl,
      goBack,
      submitForm,
      beforeUpload,
      handleSuccess
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
</style>
