<template>
  <div id="course-detail">
    <head-tabar></head-tabar>
    <div class="course-container">
      <!-- 课程基本信息 -->
      <div class="course-header">
        <img :src="course.courseCover" class="course-cover" alt="课程封面">
        <div class="course-info">
          <h2>{{ course.courseName }}</h2>
          <div class="course-meta">
            <span><i class="bi bi-tags"></i> {{ course.category }}</span>
            <span>共{{ course.lessons }}节</span>
            <span>{{ subscriberCount }}人学习</span>
          </div>
          <div class="course-progress">
            <el-progress :percentage="course.progress || 0" :stroke-width="10" />
            <span>已学习 {{ course.progress.toFixed(2) || 0 }}%</span>
          </div>
        </div>
      </div>

      <!-- 课程目录 -->
      <div class="course-content">
        <div class="course-actions">
          <h3>课程目录</h3>
          <div class="action-buttons">
            <!-- <el-button type="primary" size="small" @click="$router.push({ path: '/course', query: this.$route.params })">
              <i class="bi bi-list-ul"></i> 回到目录
            </el-button> -->
            <el-button type="success" size="small" @click="scrollToSection">
              <i class="bi bi-question-circle"></i> 提问
            </el-button>
            <el-button type="warning" size="small" @click="$router.push('/Evaluation')">
              <i class="bi bi-star"></i> 评价
            </el-button>
          </div>
        </div>
        <div class="chapter-list">
          <div class="chapter-item" v-for="(chapter, index) in chapters" :key="index">
            <div class="chapter-header" @click="toggleChapter(index)">
              <i :class="['bi', expandedChapters[index] ? 'bi-chevron-down' : 'bi-chevron-right']"></i>
              <span>第{{ index + 1 }}单元 </span>
              <span class="chapter-progress">
                <el-progress :percentage="chapter.progress" :stroke-width="6" :width="80" />
              </span>
            </div>
            <div class="section-list" v-show="expandedChapters[index]">
              <div
                  class="section-item"
                  v-for="(section, sIndex) in chapter.sections"
                  :key="sIndex"
                  @click="goToSection(chapter, section)"
                  :class="{ 'completed': section.completed }"
              >
                <i :class="['bi', section.completed ? 'bi-check-circle-fill' : 'bi-play-circle']"></i>
                <span>{{ section.chapterName }}</span>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="section-navigation">
        <el-menu
          :default-active="activeIndex"
          class="el-menu-demo"
          mode="horizontal"
          router
          @select="handleSelect"
        >
          <el-menu-item index="ask">提问</el-menu-item>
        </el-menu>
      </div>

      <div class="section-content" ref="askSectionRef">
        <div v-show=" activeIndex === 'ask'">
          <ask></ask>
        </div>

      </div>



    </div>
  </div>
</template>

<script>
import { ref, onMounted,nextTick, getCurrentInstance } from 'vue';
import HeadTabar from "@/components/HomeTaber/HeadTabar.vue";
import axios from 'axios';
import ask from '@/views/Section/ask.vue';
import { useStore } from 'vuex';
import { useRoute,useRouter } from 'vue-router';
import { findCourse } from '../../api';

export default {
  name: "CourseDetail",
  components: {
    HeadTabar,
    ask
  },
  setup() {
    const store = useStore();
    const route = useRoute();
    const { proxy } = getCurrentInstance();
    const courseId = ref(route.params.id);
    const course = ref({
      name: "基础解剖学", // 课程名称
      imgUrl: new URL('@/assets/background4.jpeg', import.meta.url).href, // 课程封面
      lessons: 0, // 总节数，后端获取
      progress: 0 // 学习进度
    });
    const subscriberCount = ref(0); // 新增学习人数
    const chapters = ref([]); // 章节数据
    const expandedChapters = ref({}); // 章节展开状态
    const activeIndex = ref('ask'); // 活动的菜单索引

    const loadCourseData = async () => {
      // const courseId = 1000; // 使用指定的课程ID
      const response = await findCourse(courseId.value);
      course.value = response.data.data;
      // console.log(course.value);
      course.value.lessons = await getLessonCount(courseId.value);
      await loadSubscriberCount(courseId.value);
      await loadChapters(courseId.value);
    };

    const loadSubscriberCount = async (courseId) => {
      const response = await axios.get(`http://localhost:8081/ucourse/count/${courseId}`);
      subscriberCount.value = response.data; // 假设返回的数值为学习人数
    };

    const getLessonCount = async (courseId) => {
      const response = await axios.get(`http://localhost:8081/section/countChapterIds/${courseId}`);
      return response.data; // 假设返回的数值为总节数
    };

    const loadChapters = async (courseId) => {
      const chapterResponse = await axios.get(`http://localhost:8081/section/show?courseId=${courseId}`);
      const chapterData = chapterResponse.data; // 假设返回的章节数据

      const maxChapterResponse = await axios.get(`http://localhost:8081/section/maxChapterBelong/${courseId}`);
      const maxChapter = maxChapterResponse.data; // 获取最大单元数

      let totalSections = 0; // 总节数
      let completedSections = 0; // 已完成节数

      for (let i = 1; i <= maxChapter; i++) {
        const sections = chapterData
          .filter(section => section.chapterBelong === i)
          .sort((a, b) => a.chapterOrder - b.chapterOrder);

        for (const section of sections) {
          section.completed = await getCompletionStatus(section.chapterId);
          totalSections++;
          if (section.completed) {
            completedSections++;
          }
        }

        const progress = sections.length > 0 ? (sections.reduce((acc, section) => acc + (section.completed ? 1 : 0), 0) / sections.length) * 100 : 0;

        chapters.value.push({
          progress: parseFloat(progress.toFixed(2)), // 保留两位小数
          sections: sections.map(section => ({
            chapterName: section.chapterName, // 使用章节名称
            completed: section.completed, // 设置完成状态
            chapterId:section.chapterId
          }))
        });
      }

      course.value.progress = totalSections > 0 ? parseFloat((completedSections / totalSections * 100).toFixed(2)) : 0;

      chapters.value.forEach((_, index) => {
        expandedChapters.value[index] = true;
      });
    };

    const getCompletionStatus = async (chapterId) => {
      const userId = store.getters.userId; // 使用指定的用户ID
      const response = await axios.get(`http://localhost:8081/progress/status?userId=${userId}&courseId=${courseId.value}&chapterId=${chapterId}`);
      return response.data; // 返回boolean值
    };

    const toggleChapter = (index) => {
      expandedChapters.value[index] = !expandedChapters.value[index];
    };

    const goToSection = (chapter, section) => {
      const router = useRouter();
      console.log(section.chapterId);
      proxy.$store.commit("setCourseId", courseId.value);
      proxy.$store.commit("setChapterId",section.chapterId)
      router.push(`/SectionContent/${section.chapterId}`);
    };

    onMounted(() => {
      loadCourseData();
    });
    const askSectionRef = ref(null);

    const scrollToSection = () => {
      nextTick(() => {
        askSectionRef.value?.scrollIntoView({
          behavior: 'smooth',
          block: 'start'
        });
      });
    };

    return {
      course,
      subscriberCount,
      chapters,
      expandedChapters,
      activeIndex,
      loadCourseData,
      loadSubscriberCount,
      getLessonCount,
      loadChapters,
      getCompletionStatus,
      toggleChapter,
      scrollToSection,
      askSectionRef,
      goToSection
    };
  }
};
</script>

<style scoped>
#course-detail {
  padding: 20px;
  background: #f5f7fa;
  min-height: 100vh;
}

.course-container {
  max-width: 1200px;
  margin: 80px auto 0 auto;
  background: #fff;
  border-radius: 8px;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
  padding: 20px;
}

.course-header {
  display: flex;
  margin-bottom: 30px;
}

.course-cover {
  width: 240px;
  height: 135px;
  border-radius: 8px;
  object-fit: cover;
  margin-right: 20px;
}

.course-info {
  flex: 1;
}

.course-info h2 {
  margin: 0 0 10px 0;
  font-size: 24px;
  color: #333;
}

.course-meta {
  display: flex;
  gap: 15px;
  margin-bottom: 15px;
  color: #666;
  font-size: 14px;
}

.course-progress {
  margin-top: 20px;
}

.course-progress span {
  display: block;
  margin-top: 5px;
  font-size: 14px;
  color: #666;
}

.course-content h3 {
  margin: 0 0 20px 0;
  padding-bottom: 10px;
  border-bottom: 1px solid #eee;
  font-size: 18px;
  color: #333;
}

.chapter-list {
  border: 1px solid #eee;
  border-radius: 4px;
}

.chapter-item {
  border-bottom: 1px solid #eee;
}

.chapter-item:last-child {
  border-bottom: none;
}

.chapter-header {
  display: flex;
  align-items: center;
  padding: 15px;
  cursor: pointer;
  background-color: #f9f9f9;
}

.chapter-header:hover {
  background-color: #f0f0f0;
}

.chapter-header i {
  margin-right: 10px;
  font-size: 14px;
}

.chapter-header span {
  flex: 1;
  font-size: 16px;
  font-weight: 500;
}

.chapter-progress {
  width: 100px;
  margin-left: 20px;
}

.section-list {
  padding: 0 15px;
}

.section-item {
  display: flex;
  align-items: center;
  padding: 12px 15px;
  border-bottom: 1px dashed #eee;
  cursor: pointer;
}

.section-item:last-child {
  border-bottom: none;
}

.section-item:hover {
  background-color: #f9f9f9;
}

.section-item.completed {
  color: #67c23a;
}

.section-item i {
  margin-right: 10px;
  font-size: 16px;
}

.section-item span {
  flex: 1;
  font-size: 14px;
}

.section-duration {
  color: #999;
  font-size: 12px;
}
.course-actions {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
  padding-bottom: 10px;
  border-bottom: 1px solid #eee;
}

.action-buttons {
  display: flex;
  gap: 10px;
}

.action-buttons .el-button {
  display: flex;
  align-items: center;
}

.action-buttons .bi {
  margin-right: 5px;
}
.section-navigation {
  margin: 20px 0;
}
/* .el-menu-demo {
  border-bottom: none;
}
.el-menu-item {
  font-size: 16px;
  color: #666;
}
.el-menu-item.is-active {
  color: #7b9e31;
  border-bottom: 2px solid #7b9e31;
} */
</style>
