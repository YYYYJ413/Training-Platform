<template>
  <div id="study-course">
    <div>
      <el-button type="primary" round icon="el-icon-plus" style="box-shadow: 2px 2px 2px #ccc;margin-left: 20px"
                 @click="addcourse()">
        添加课程
      </el-button>
      <el-input placeholder="请输入内容" prefix-icon="el-icon-search" v-model="input1"
                style="width: 200px;float: right" @keyup.enter.native="search()"></el-input>
    </div>
    <div style="margin-top: 30px">
      <ul style="list-style: none;padding: 0">
        <li v-for="(course,index) in courses">
          <div @click="courseId(course.courseId,course.courseName, course.jwt)">
            <el-image :src="course.courseCover" style="width: 280px;height: 200px;border-radius: 20px;"></el-image>
            <h3 >{{ course.courseName }}</h3>
            <h5>学校：{{ course.schoolName }}</h5>
            <h5>老师：{{ course.userName }}</h5>
            <h5>开课时间：{{ course.gmtStart }} ~ {{ course.gmtEnd }}</h5>
            <el-image src="/assets/courseimg.jpg"></el-image>
          </div>

        </li>
      </ul>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import { findCourse, getAllCourse } from "../../api";

export default {
  name: "StudyCourse",
  data() {
    return {
      input1: '',
      courses: [],
    }
  },
  watch: {
    // 监听input输入框，若没东西了，就回复默认状态
    input1: function (newnew, oldold) {
      if (newnew == "") {
        // 发请求回到初始列表数据状态
        console.log("搜索框没东西了，回复初始状态");
      }
    }
  },
  methods: {
    courseId(courseIndex, courseName, jwt) {
      console.log(courseIndex, courseName)
      let courseInfo = {
        courseName: courseName,
        courseIndex: courseIndex
      }
      this.$store.commit("updateCourseName", courseInfo)
      // this.$router.push('/Section/SectionIndex')
      window.open(this.$examUrl + jwt)
    },
    addcourse() {
      this.$prompt('请输入课程邀请码', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
      }).then(({value}) => {
        axios('/course/addcourse', {
          params: {
            userId: localStorage.getItem("userId"),
            courseCode: value
          },
          method: "post",
        }).then(res => {
          // console.log(res.data)
          location.reload()
        }).catch(function (error) {
          console.log(error);
        });
      }).catch(() => {
        this.$message({
          type: 'info',
          message: '取消输入'
        });
      });
    },
    search() {
      if (this.input1 == "") {
        return
      } else {
        for (var i = 0; i < this.courses.length; i++) {
          if (this.input1==this.courses[i].courseName){
            let courseInfo = {
              courseName: this.courses[i].courseName,
              courseIndex: this.courses[i].courseId
            }
            this.$store.commit("updateCourseName", courseInfo)
            // this.$router.push('/Section/SectionIndex')
            let routerUrl = this.$router.resolve({
              path: "/Section/SectionIndex"
            })
            window.open(routerUrl.href)
            break;
          }
        }
      }
    }
  },
  mounted() {
    console.log('Component mounted');
    getAllCourse().then(res => {
      console.log(res.data)
      this.courses = res.data.data
    })
  }
}
</script>

<style scoped>
#study-course {
  padding-bottom: 100px;
}

h5 {
  margin: 0px;
  padding: 5px;
  font-size: 13px;
  color: #a8a8b3;
}

h3 {
  margin: 0;
  padding: 10px;
}

li {
  margin-bottom: 20px;
  display: inline-block;
  padding-right: 30px;
  padding-left: 30px;
  width: 330px;
}

img:hover {
  cursor: pointer;
}

h3:hover {
  cursor: pointer;
  color: cornflowerblue;
}
</style>
