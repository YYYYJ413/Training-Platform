<template>
  <div id="section">
    <head-tabar></head-tabar>
    <el-container>
      <el-header>
        <course-head></course-head>
      </el-header>
      <el-main style="margin-top: 80px;">
        <router-view></router-view>
      </el-main>
    </el-container>
  </div>
</template>

<script>
import HeadTabar from "../../components/HomeTaber/HeadTabar.vue";
import CourseHead from "../../components/HomeTaber/CourseHead.vue";

export default {
  name: "Section",
  components: {
    HeadTabar,
    CourseHead
  },
}

</script>

<style scoped>

</style>
