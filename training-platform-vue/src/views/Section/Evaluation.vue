<template>
  <div id="evaluation">
    <head-tabar></head-tabar>
    <div style="position:absolute;margin-top: 80px;border-bottom: 1px solid #d6d6d6;width: 100%;padding-bottom: 10px">
      <span class="courseNamecss" style="font-size: 25px;margin-left: 20%">{{ courseName }}</span>
    </div>
    <div
        style="position: absolute;margin-top: 150px;border: 1px solid #d6d6d6;margin-left: 25%;width: 800px;padding: 20px">
      <div style="border-bottom: 1px solid #d6d6d6;padding-bottom: 10px">
        <h2 style="width: 100px;">课程评价</h2>
        平均评分：
        <el-rate v-model="average" disabled show-score text-color="#ff9900"></el-rate>
      </div>
      <p style="width: 100px">知识量：</p>
      <el-rate v-model="value1" show-score @change="changeValue1(value1)"></el-rate>
      <p style="width: 100px">趣味性：</p>
      <el-rate v-model="value2" show-score @change="changeValue2(value2)"></el-rate>
      <p style="width: 100px">教师参与：</p>
      <el-rate v-model="value3" show-score @change="changeValue3(value3)"></el-rate>
      <p style="width: 100px">课程设计：</p>
      <el-rate v-model="value4" show-score @change="changeValue4(value4)"></el-rate>
      <div style="margin-top: 20px;">
        <p style="width: 100px; text-align: left;">课程评论：</p>
        <textarea v-model="comment" rows="5" cols="50"></textarea>
      </div>
      <div style="margin-top: 20px;margin-left: 40%">
        <el-button type="success" @click="submit()">提交</el-button>
        <el-button type="info" @click="returnUrl()">返回</el-button>
      </div>
    </div>
  </div>
</template>

<script>
import HeadTabar from "../../components/HomeTaber/HeadTabar.vue";
import axios from "axios";

export default {
  name: "Evaluation",
  data() {
    return {
      courseName: localStorage.getItem("course_name"),
      value1: null,
      value2: null,
      value3: null,
      value4: null,
      comment: ''
    }
  },
  components: {
    HeadTabar
  },
  computed: {
    average() {
      if (this.value1 != null && this.value2 != null && this.value3 != null && this.value4 != null) {
        return ((this.value1 + this.value2 + this.value3 + this.value4) / 4);
      } else {
        return null;
      }
    }
  },
  methods: {
    changeValue1(value1) {
      this.value1 = value1;
    },
    changeValue2(value2) {
      this.value2 = value2;
    },
    changeValue3(value3) {
      this.value3 = value3;
    },
    changeValue4(value4) {
      this.value4 = value4;
    },
    returnUrl() {
      if (this.$route.query.fromCourse) {
        this.$router.push({ path: `/course/${this.$route.query.fromCourse}` });
      } else {
        this.$router.go(-1); // 如果没有来源课程ID，则简单返回上一页
      }
      // // 检查是否存在上一个路由信息
      // if (this.$router.history && this.$router.history.current && this.$router.history.current.meta && this.$router.history.current.meta.prevRoute) {
      //   this.$router.push(this.$router.history.current.meta.prevRoute);
      // } else {
      //   // 如果没有上一个路由信息，默认返回课程页面
      //   this.$router.push({ path: '/course', query: this.$route.params });
      // }
    },
    submit() {
      const userId = '7d9030e8cb5841c288c7d8b2412b97cc';
      const courseId = 1000;
      const assessScore = this.average;
      const assessContent = this.comment;


      axios.post('http://localhost:8081/assess/create', null, {
        params: {
          userId,
          courseId,
          assessScore,
          assessContent
        }
      })
          .then(response => {
            console.log(response.data);
            alert("评价提交成功！");

          })
          .catch(error => {
            console.error("提交失败：", error.response ? error.response.data : error.message);
            alert("提交失败，请重试。");
          });

    }

  }
}
</script>

<style scoped>
textarea {
  width: 400px; /* 可按需调整宽度 */
  margin-left: 1px; /* 与左侧标签间隔 */
}
</style>
