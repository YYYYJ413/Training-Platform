<template>
  <div id="course">
    <head-tabar></head-tabar>
    <div id="choice" class="chooseType">
      <el-row :gutter="20">
        <el-col :span="100" v-for="(course, index) in paginatedCourses" :key="index"
          style="margin-bottom: 50px; width: 375px; height: 278px;">
          <el-card shadow="hover" class="course-card">
            <div class="card-badge" v-if="course.courseType">必修</div>
            <img :src="course.courseCover" class="card-image" alt="课程图片">
            <div class="card-content">
              <h4>{{ course.courseName }}</h4>
              <div class="card-meta">
                <span><i class="bi bi-tags"></i>&nbsp;{{ course.courseTeacher }}</span>
                <span>{{ course.lessonCount }}节</span>
                <span><i class="bi bi-people"></i>&nbsp;{{ course.subscriberCount }}人学习</span>
              </div>
            </div>
            <el-button type="primary" @click="chooseCourse(course.courseId)" style="float: right;margin-bottom: 10px;">
              选择课程
            </el-button>
          </el-card>
        </el-col>
      </el-row>
    </div>
    <el-pagination background layout="prev, pager, next" :total="courses.length" :page-size="pageSize"
      @current-change="handleCurrentChange" style="margin-top: 20px; text-align: center;float: right;" />
  </div>
</template>

<script>
import { ref, computed, onMounted } from 'vue';
import HeadTabar from "../../components/HomeTaber/HeadTabar.vue";
import { choose, getAllCourse, getchapterData, getSubscriberCount } from '../../api';
import { useStore } from 'vuex';
import { ElMessage, ElMessageBox } from 'element-plus';

export default {
  name: "Course",
  components: {
    HeadTabar
  },
  setup() {
    const currentPage = ref(1);
    const pageSize = ref(9); // 每页显示8个课程
    const store = useStore();
    const courses = ref([
      // {
      //   name: '基础解剖学',
      //   category: '临床医学类',
      //   imgUrl: new URL('../../assets/background4.jpeg', import.meta.url).href,
      //   isPremium: true,
      //   lessons: 12,
      //   subscribers: 356,
      //   courseType: '必修课'
      // },
      // {
      //   name: '研究人体正常生命活动机制',
      //   category: '临床医学类',
      //   imgUrl: new URL('../../assets/background5.jpeg', import.meta.url).href,
      //   isPremium: true,
      //   lessons: 122,
      //   subscribers: 223,
      //   courseType: '必修课'
      // },
      // {
      //   name: '室外空气与人体健康',
      //   category: '公共卫生类',
      //   imgUrl: new URL('../../assets/background6.jpeg', import.meta.url).href,
      //   isPremium: true,
      //   lessons: 130,
      //   subscribers: 122,
      //   courseType: '公选课'
      // }
    ]);

    const handleCurrentChange = (val) => {
      currentPage.value = val;
    };

    const paginatedCourses = computed(() => {
      const start = (currentPage.value - 1) * pageSize.value;
      const end = start + pageSize.value;
      return courses.value.slice(start, end);
    });

    const loadCourseData = () => {
      getAllCourse().then(async (res) => {
        courses.value = res.data.data;
        // console.log(courses.value);
        // 为每个课程获取节数
        for (const course of courses.value) {

          const countRes = await getchapterData(course.courseId)
          course.lessonCount = countRes.data.length;

          const response = await getSubscriberCount(course.courseId);
          course.subscriberCount = response.data;
        }
      });
    }

    const chooseCourse = (courseId) => {
      if (!store.getters.token) {
        ElMessage.error('请先登录');
      } else {
        ElMessageBox.confirm('确定选择该课程吗？', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type:'info'
        }).then(() => {
          const userId = store.getters.userId;
          choose(userId, courseId).then((res) => {
            if (res.data.code === 0) {
              ElMessage.success('选择成功');
            } else {
              ElMessage.error('已选择该课程');
            }
          }).catch(err=>{
            ElMessage.error('已选择该课程');
          })  
        })
      }
    }

    onMounted(() => {
      loadCourseData();
    })

    return {
      currentPage,
      pageSize,
      courses,
      handleCurrentChange,
      paginatedCourses,
      chooseCourse,
    };
  }
};
</script>

<style scoped>
#course {
  height: auto;
  width: 100vw;
  padding: 80px;
  background: #ebeef5;
}

.chooseType {
  margin-top: 20px;
  margin-left: 80px;
  display: flex;
  margin-bottom: 20px;
}

.course-card {
  position: relative;
  border-radius: 8px;
  overflow: hidden;
  cursor: pointer;
  transition: all 0.3s;
}

.course-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
}

.card-badge {
  position: absolute;
  top: 10px;
  right: 10px;
  background: #ff4d4f;
  color: white;
  padding: 2px 8px;
  border-radius: 10px;
  font-size: 12px;
  z-index: 1;
}

.card-image {
  width: 100%;
  height: 160px;
  object-fit: cover;
}

.card-content {
  padding: 15px;
}

.card-content h4 {
  margin: 0 0 10px 0;
  font-size: 16px;
  color: #333;
}

.card-meta {
  display: flex;
  justify-content: space-between;
  font-size: 12px;
  color: #666;
}
</style>