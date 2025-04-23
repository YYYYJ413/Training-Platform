<template>
  <div id="home">
    <head-tabar></head-tabar>
    <el-container
      style="margin-top: 70px;min-height: calc(100vh - 70px);display: flex;justify-self:center;flex-direction: column;">
      <div class="top-section">
        <!-- 左侧课程目录 -->
        <div class="course-categories">
          <div class="category-item" v-for="category in categories" :key="category.id">
            <div class="category-title">
              <i :class="'bi bi-' + category.icon"></i>
              <span>{{ category.name }}</span>
            </div>
            <ul class="category-content">
              <li v-for="(item, index) in category.items" :key="item.id">
                <span class="item-name">
                  {{ item.name }}{{ index < category.items.length - 1 ? ' / ' : '' }} </span>
              </li>
            </ul>
          </div>
        </div>

        <!-- 右侧轮播图 -->
        <div class="carousel-container">
          <el-carousel height="360px">
            <el-carousel-item v-for="item in carouselItems" :key="item.id">
              <img :src="item.src" alt="轮播图">
            </el-carousel-item>
          </el-carousel>
        </div>
      </div>
      <div class="second-section">
        <div class="course-list">
          <div class="course-tabs">
            <h2 class="premium-title">精品课堂</h2>
            <div v-for="(tab, index) in tabs" :key="index" :class="['tab-item', { 'active': activeTab === index }]"
              @click="activeTab = index">
              {{ tab }}
            </div>
          </div>
          <div class="course-grid">
            <div class="course-card" v-for="(course, index) in filteredCourses" :key="index">
              <div class="card-badge" v-if="course.isPremium">精品</div>
              <img :src="course.courseCover" class="card-image" alt="课程图片">
              <div class="card-content">
                <h4>{{ course.courseName }}</h4>
                <div class="card-meta">
                  <span><i class="bi bi-tags"></i>&nbsp;{{ course.courseTeacher }}</span>
                  <span>{{ course.lessonCount }}节</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <el-main style="padding: 0;margin-left: 20px;margin-right: 20px">
        <router-view></router-view>
      </el-main>
    </el-container>
  </div>
</template>

<script>
import { ref, computed, onMounted } from 'vue';
import HeadTabar from '../../components/HomeTaber/HeadTabar.vue';
import { useStore } from 'vuex';
import { ElMessage } from 'element-plus';
import { getAllCourse, getchapterData, getCourseList, getSubscriberCount } from '../../api';

export default {
  name: "Home",
  components: {
    HeadTabar
  },
  setup() {
    const store = useStore();
    const token = computed(() => store.getters.token);
    const headImg = computed(() => store.getters.userImg);
    const name = computed(() => store.getters.userName);

    const activeTab = ref(0);
    const tabs = ref(['推荐']);
    const courses = ref([]);
    const carouselItems = ref([
      { id: 1, src: new URL('../../assets/background1.jpeg', import.meta.url).href },
      { id: 2, src: new URL('../../assets/background2.jpeg', import.meta.url).href },
      { id: 3, src: new URL('../../assets/background3.jpeg', import.meta.url).href }
    ]);
    const categories = ref([
      {
        id: 1,
        name: '基础医学',
        icon: 'collection',
        items: [
          { id: 101, name: '人体结构与功能' },
          { id: 102, name: '微生物与免疫学' }
        ]
      },
      {
        id: 2,
        name: '临床医学',
        icon: 'hospital',
        items: [
          { id: 201, name: '内科诊疗技术' },
          { id: 202, name: '外科手术基础' }
        ]
      }
    ]);

    const filteredCourses = computed(() => {
      if (activeTab.value === 0) { // 推荐标签显示所有课程
        return randomSample(courses.value, 8); 
      } else {
        const tabName = tabs.value[activeTab.value];
        return courses.value.filter(course => course.category === tabName);
      }
    });

    const randomSample = (array, count) => {
      const shuffled = array.sort(() => 0.5 - Math.random());
      return shuffled.slice(0, count);
    };

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

    onMounted(() => {
      loadCourseData();
    })

    return {
      token,
      headImg,
      name,
      activeTab,
      tabs,
      courses,
      carouselItems,
      categories,
      filteredCourses
    };
  }
};
</script>

<style scoped>
#home {
  position: relative;
  min-height: 100vh;
  width: 100%;
  background: linear-gradient(to bottom, #87cefa, #ffffff);
}

.top-section {
  display: flex;
  width: 1200px;
  height: 360px;
  margin: 0 auto;
  border-radius: 8px;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
}

.course-categories {
  color: #ffffff;
  width: 40%;
  padding: 15px;
  background: #0f2038;
  border-radius: 4px;
  position: relative;
}

.category-item {
  display: flex;
  align-items: center;
  margin-bottom: 10px;
}

.category-title {
  white-space: nowrap;
  margin-bottom: 5px;
}

.category-content {
  display: flex;
  list-style: none;
  padding-left: 0;
  margin: 5px 0;
}

.item-name {
  display: inline;
  white-space: nowrap;
}

.carousel-container {
  width: 70%;
  margin-left: 20px;
  height: 360px;
  position: relative;
}

.el-carousel {
  height: 100%;
  position: relative;
}

.el-carousel img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  border-radius: 4px;
}

.el-carousel::after {
  content: '';
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  height: 30px;
  background: linear-gradient(to bottom, transparent, rgba(255, 255, 255, 0.9));
}

.second-section {
  width: 1200px;
  margin: 20px auto;
}

.premium-title {
  font-size: 24px;
  color: #333;
  margin-bottom: 20px;
  font-weight: bold;
  position: relative;
  padding-left: 15px;
}

.premium-title::before {
  content: '';
  position: absolute;
  left: 0;
  top: 50%;
  transform: translateY(-50%);
  width: 4px;
  height: 20px;
  background: #ff0000;
}

.course-tabs {
  display: flex;
  border-bottom: 1px solid #eee;
  margin-bottom: 20px;
}

.tab-item {
  padding: 10px 20px;
  cursor: pointer;
  position: relative;
  margin-right: 10px;
}

.tab-item.active {
  color: #ff0000;
}

.tab-item.active::after {
  content: '';
  position: absolute;
  bottom: -1px;
  left: 0;
  right: 0;
  height: 2px;
  background: #ff0000;
}

.course-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 20px;
}

.course-card {
  border: 1px solid #eee;
  border-radius: 8px;
  overflow: hidden;
  position: relative;
  transition: all 0.3s;
  background-color: #ffffff;
}

.course-card:hover {
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
}

.card-badge {
  position: absolute;
  top: 10px;
  right: 10px;
  background: #ff0000;
  color: white;
  padding: 2px 8px;
  border-radius: 4px;
  font-size: 12px;
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
  margin: 0 0 10px;
  font-size: 16px;
}

.card-meta {
  display: flex;
  justify-content: space-between;
  font-size: 12px;
  color: #666;
}
</style>