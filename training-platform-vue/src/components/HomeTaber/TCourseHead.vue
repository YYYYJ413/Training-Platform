<template>
  <div style="padding-top: 80px;border-bottom: 1px #b3b3b3 solid;padding-bottom: 10px" id="tcourse-head">

    <span class="courseNamecss">{{ courseName }}</span>
    <router-link to>课程门户</router-link>
    <div style="float: right;margin-right: 100px;margin-top: -10px;">
      <el-menu default-active="/Teaching/TSectionindex" class="el-menu-demo" mode="horizontal" router>
        <el-menu-item index="/Teaching/TSectionindex">首页</el-menu-item>
        <el-menu-item index="/Teaching/Ttask">活动</el-menu-item>
        <!-- <el-menu-item index="/Teaching/TStatistics">统计</el-menu-item> -->
        <el-menu-item index="/Teaching/TMaterial">资料</el-menu-item>
        <!-- <el-menu-item index="/Teaching/TNotify">通知</el-menu-item> -->
        <el-menu-item index="/Teaching/TOperation">作业</el-menu-item>
        <el-menu-item index="/Teaching/TExam">考试</el-menu-item>
        <el-menu-item index="/Teaching/TDiscuss">讨论</el-menu-item>
      </el-menu>
    </div>
  </div>
</template>

<script>
export default {
  name: "TCourseHead",
  data() {
    return {
      courseName: localStorage.getItem("courseName"),
      index: localStorage.getItem("courseIndex")
    }
  },
}
</script>

<style scoped>
.courseNamecss {
  font-size: 30px;
  margin-left: 300px;
  color: #7b9e31;
}

ul li {
  display: inline;
  margin-left: 20px;
  font-size: 20px;
}

a {
  margin-left: 10px;
  color: #7b9e31
}
</style>
