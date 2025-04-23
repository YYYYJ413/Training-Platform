<template>
  <div style="padding-top: 80px;border-bottom: 1px #b3b3b3 solid;padding-bottom: 10px;display: flex; justify-content: space-between;width: 100%;" id="course-head">

    <span class="courseNamecss">{{ courseName }}</span>
    <router-link :to="{path:'/Evaluation'}">课程评价</router-link>
    <div style="float: right;margin-right: 100px;margin-top: -10px;">
      <el-menu 
        :default-active="activeIndex" 
        class="el-menu-demo" 
        mode="horizontal" 
        router
        @select="handleSelect"
      >
        <el-menu-item index="/Section/Sectionindex">任务</el-menu-item>
        <el-menu-item index="/Section/Task">提问</el-menu-item>
        <el-menu-item index="/Section/Material">资料</el-menu-item>
        <el-menu-item index="/Section/Exam">考试</el-menu-item>
      </el-menu>
    </div>
  </div>
</template>

<script>
export default {
  name: "CourseHead",
  data() {
    return {
      courseName: localStorage.getItem("courseName"),
      index: localStorage.getItem("courseIndex"),
      activeIndex: this.$route.path // 获取当前路由路径作为默认激活项
    }
  },
  methods: {
    handleSelect(index) {
      this.activeIndex = index;
      // 这里可以添加其他处理逻辑
    }
  },
  watch: {
    '$route'(to) {
      this.activeIndex = to.path; // 路由变化时更新激活项
    }
  }
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
