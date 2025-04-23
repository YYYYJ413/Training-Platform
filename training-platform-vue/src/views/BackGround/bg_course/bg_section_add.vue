<template>
  <div>
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: '/HomePage' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>课程管理</el-breadcrumb-item>
      <el-breadcrumb-item>添加课程章节</el-breadcrumb-item>
    </el-breadcrumb>
    <el-card>
      <div v-for="(section, index) in sections" :key="index" class="section-item">
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
          <el-button type="danger" @click="removeSection(index)">删除</el-button>
        </el-form>
      </div>
      <el-button type="primary" @click="addSection">添加小节</el-button>
      <div class="button-group">
        <el-button @click="goBack">取消</el-button>
        <el-button type="primary" @click="submitSections">提交</el-button>
      </div>
    </el-card>
  </div>
</template>

<script>
import { onMounted, ref } from 'vue';
import { ElMessage } from 'element-plus';
import axios from 'axios';
import {useRouter} from "vue-router";
export default {
  setup() {
    const router=useRouter();

    const sections = ref([
      {
        chapterBelong: '',
        chapterOrder: '',
        chapterName: '',
        chapterContent: '',
        courseId: Number(router.currentRoute.value.query.courseId),
      }
    ]);
    const goBack = () => {
      resetSections();
      router.push({ path: '/bg_home/c' });
    };
    const addSection = () => {
      sections.value.push({
        chapterBelong: '',
        chapterOrder: '',
        chapterName: '',
        chapterContent: '',
        courseId: Number(router.currentRoute.value.query.courseId),
      });
    };
    const removeSection = (index) => {
      sections.value.splice(index, 1);
    };
    const submitSections = () => {
      // 这里假设从gb_course_add.vue页面获取到了course_id，实际需要根据业务逻辑传递过来
      const sectionData = sections.value.map(section => ({
        chapterBelong: Number(section.chapterBelong),
        chapterOrder: section.chapterOrder,
        chapterName: section.chapterName,
        chapterContent: section.chapterContent,
        courseId: section.courseId
      }));
      console.log(sectionData);
      // 修改请求地址为后端新添加的接口地址
      axios.post('http://localhost:8081/section/submitSections', sectionData)
          .then(response => {
            if (response.data.code===0) {
              ElMessage.success('提交成功');
              resetSections();
              router.push(`/bg_home/c`)
            } else {
              ElMessage.error('提交失败');
            }
          })
          .catch(error => {
            console.error(error);
            ElMessage.error('提交失败');
          });
    };
    const resetSections = () => {
      sections = ([
        {
          chapterBelong: '',
          chapterOrder: '',
          chapterName: '',
          chapterContent: '',
          courseId: Number(router.currentRoute.value.query.courseId),
        }
      ]);
    };
    return {
      sections,
      goBack,
      addSection,
      removeSection,
      submitSections,
      resetSections
    };
  }
};
</script>

<style>
.section-item {
  border: 1px solid #e4e7ed;
  border-radius: 4px;
  padding: 15px;
  margin-bottom: 10px;
}

.button-group {
  text-align: right;
  margin-top: 20px;
}
</style>