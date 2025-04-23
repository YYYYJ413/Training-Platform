<template>
  <div id="section-content">
    <head-tabar></head-tabar>
    <div class="main-container">
      <div class="back-button">
        <el-button @click="router.go(-1)"><el-icon><back/></el-icon>返回课程</el-button>  
      </div>
      <div class="video-container">
        <h2 style="color: #7b9e31;text-align: center">{{ courseName }}</h2>
        <p style="text-align: center;">{{ label }}</p>
        <video controls width="100%" @timeupdate="updateVideoTime" @ended="handleVideoEnded">
          <source :src="videoSrc" type="video/mp4">
          <source :src="videoSrc.replace('.mp4', '.webm')" type="video/webm">
          <source :src="videoSrc.replace('.mp4', '.ogg')" type="video/ogg">
          您的浏览器不支持 video 标签。
        </video>
        <div class="note-container">
          <div class="note-header">
            <h3 class="note-title">笔记</h3>
            <el-button v-if="!isCreatingNote" @click="toggleCreateNote" type="primary" size="small"
              style="font-weight: bold; font-family: 黑体; margin-left: 10px;">
              新建笔记
            </el-button>
          </div>
          <div v-if="isCreatingNote" class="note-create">
            <el-input type="textarea" autosize placeholder="请输入笔记内容" v-model="noteContent">
            </el-input>
            <div class="note-create-actions">
              <el-button type="success" @click="submitNote">提交</el-button>
              <el-button type="info" @click="toggleCreateNote">取消</el-button>
            </div>
          </div>
          <div class="note-display">
            <ul>
              <li v-for="(note, index) in notes" :key="index">
                <div class="note-item">
                  <span class="note-time">{{ note.noteTime }}</span>
                  <div class="note-text">
                    <span v-if="!note.isEditing">{{ note.noteContent }}</span>
                    <el-input v-else type="textarea" autosize placeholder="请输入修改后的笔记内容" v-model="note.editingContent">
                    </el-input>
                  </div>
                  <div class="note-actions">
                    <el-button v-if="!note.isEditing" type="primary" size="small" @click="editNote(index)">
                      编辑
                    </el-button>
                    <el-button v-if="note.isEditing" type="success" size="small" @click="saveEdit(index)">
                      保存
                    </el-button>
                    <el-button v-if="note.isEditing" type="info" size="small" @click="cancelEdit(index)">
                      取消
                    </el-button>
                    <el-button v-if="!note.isEditing" type="danger" size="small" @click="deleteNote(index)">
                      删除
                    </el-button>
                  </div>
                </div>
              </li>
            </ul>
          </div>
        </div>
      </div>
      <div class="section-list-container"
        style="margin-left: 28px;background: #f0f0f0;border: 1px #b3b3b3 solid;border-radius: 8px; max-height: 600px; overflow-y: auto;">
        <h3>课程目录</h3>
        <div class="chapter-list">
          <div class="chapter-item" v-for="(chapter, index) in chapters" :key="index">
            <div class="chapter-header" @click="toggleChapter(index)">
              <i :class="['bi', expandedChapters[index] ? 'bi-chevron-down' : 'bi-chevron-right']"></i>
              <span>第{{ index + 1 }}单元</span>
            </div>
            <div class="section-list" v-show="expandedChapters[index]">
              <div class="section-item" v-for="(section, sIndex) in chapter.sections" :key="sIndex"
                @click="goToSection(chapter, section)"
                :class="{ 'completed': section.completed, 'active': isActiveSection(section) }">
                <i :class="['bi', section.completed ? 'bi-check-circle-fill' : 'bi-play-circle']"></i>
                <span>{{ section.chapterName }}</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted, watch, computed } from 'vue';
import HeadTabar from "../../components/HomeTaber/HeadTabar.vue";
import axios from "axios";
import { useStore } from 'vuex';
import { useRoute, useRouter } from 'vue-router';
import { getProgress, updateProgress } from '../../api';

const router = useRouter();
const route = useRoute();
const store = useStore();
const sectionContent = localStorage.getItem('sectionContent');
const label = localStorage.getItem('label');
const courseName = localStorage.getItem('courseName');
const courseId = computed(() => store.getters.courseId);;
const userId = computed(() => store.getters.userId);;
const chapterId = ref('');
const videoSrc = ref('');
const chapters = ref([]);
const expandedChapters = reactive({});
const isCreatingNote = ref(false);
const noteContent = ref('');
const currentVideoTime = ref(0);
const notes = ref([]);
const currentSection = ref({
  chapterName: '',
  completed: false,
  chapterId: null,
  chapterContent: '',
  chapterBelong: null,
  chapterOrder: null,
  progress: [],
});
const currentChapter = ref();
const lastVideoTime = ref(0);

const loadCourseData = async () => {
  await loadChapters(courseId.value);
  await loadNotes(courseId.value, chapterId.value,); // 新增：加载笔记
  currentChapter.value = getChapterById(chapters.value, chapterId.value)
  // if (chapters.value.length > 0 && chapters.value[0].sections.length > 0) {
  //   currentChapter.value = chapters.value[0]; // 设置当前章节
  //    // 自动播放第一个部分
  // }
  console.log(currentChapter.value);
  goToSection(currentChapter.value, currentChapter.value);
};
const getChapterById = (chapters, chapterId) => {
  // console.log(chapters, chapterId);
  // 遍历 chapters 数组
  for (const chapter of chapters) {
    // 遍历每个章节的 sections 数组
    for (const section of chapter.sections) {
      // 检查 section 的 chapterId 是否匹配
      if (section.chapterId === Number(chapterId)) {
        // console.log('section:', section)
        return section; // 返回匹配的章节信息
      }
    }
  }
  return null; // 如果没有找到匹配的章节，返回 null
};
const loadChapters = async (courseId) => {
  const chapterResponse = await axios.get(`http://localhost:8081/section/show?courseId=${courseId}`);
  const chapterData = chapterResponse.data;
  // 打印章节数据以进行调试
  // 按照 chapterBelong 进行排序，然后按照 chapterOrder 进行排序
  // 计算最大的 chapterBelong 作为循环的次
  // console.log(courseId);
  const maxChapterResponse = await axios.get(`http://localhost:8081/section/maxChapterBelong/${courseId}`);
  const maxChapter = maxChapterResponse.data;
  for (let i = 1; i <= maxChapter; i++) {
    const sections = chapterData
      .filter(section => section.chapterBelong === i)
      .sort((a, b) => a.chapterOrder - b.chapterOrder);

    for (const section of sections) {
      section.completed = await getCompletionStatus(section.chapterId);
      await getProgress(userId.value, courseId, section.chapterId).then(res => {
        // console.log(res.data);
        section.progress = res.data;
      })
    }
    chapters.value.push({
      sections: sections.map(section => ({
        chapterName: section.chapterName,
        completed: section.completed,
        chapterId: section.chapterId,
        chapterContent: section.chapterContent,
        chapterBelong: section.chapterBelong,
        chapterOrder: section.chapterOrder,
        progress: section.progress
      }))
    });
    console.log('chapters:',chapters.value); // 打印章节数据以进行调试
  }

  chapters.value.forEach((_, index) => {
    expandedChapters[index] = true;
  });
};

const loadNotes = async (curCourseId, chapterId) => {
  try {
    const notesResponse = await axios.get(`http://localhost:8081/notes/show?userId=${userId.value}&courseId=${curCourseId}&chapterId=${chapterId}`);
    notes.value = notesResponse.data.map(note => ({
      noteTime: note.noteTime,
      noteContent: note.noteContent,
      isEditing: false
    }));
  } catch (error) {
    console.error("Error loading notes:", error);
  }
};

const getCompletionStatus = async (curchapterId) => {
  const response = await axios.get(`http://localhost:8081/progress/status?userId=${userId.value}&courseId=${courseId.value}&chapterId=${curchapterId}`);
  return response.data; // 返回boolean值
};

const toggleChapter = (index) => {
  expandedChapters[index] = !expandedChapters[index];
};

const goToSection = (chapter, section) => {
  loadNotes(courseId.value, section.chapterId);
  currentSection.value = section;
  console.log(currentSection.value);
  // 强制更新视频源并重新加载播放器
  videoSrc.value = section.chapterContent + '?t=' + new Date().getTime();

  // 添加视频加载逻辑
  const video = document.querySelector('video');
  if (video) {
    video.load();
    video.play().catch(error => {
      console.error('自动播放失败:', error);
    });
  }
  // console.log(courseId, section.chapterId);
  // 修正路由参数传递
  router.push(`/SectionContent/${section.chapterId}`);
};

const updateVideoTime = () => {
  const video = document.querySelector('video');
  if (video) {
    const currentTime = Math.floor(video.currentTime);
    // 检查是否拖动进度条
    if ((currentTime - lastVideoTime.value) > 1) {
      // 如果拖动超过1秒，回到上一个视频时间
      video.currentTime = lastVideoTime.value;
    } else {
      // 更新当前视频时间
      currentVideoTime.value = currentTime;
      lastVideoTime.value = currentTime; // 更新上一个视频时间
    }
  }
};
//视频播放完成
const handleVideoEnded = () => {
  currentSection.value.progress.isFinished = 1;
  updateProgress(currentSection.value.progress).then(res => {
    if (res.data.code === 0) {
      console.log('视频播放完成,进度已更新', currentSection.value.progress);  
      // loadCourseData();
    } else {
      console.log(res.data.message);
    }
  }).catch(err => {
    console.error(err);
  })
  
}

const toggleCreateNote = () => {
  isCreatingNote.value = !isCreatingNote.value;
};

const submitNote = async () => {
  if (noteContent.value.trim() === '') return;

  const noteTime = formatTime(currentVideoTime.value);

  try {
    await axios.post('http://localhost:8081/notes', null, {
      params: {
        userId: userId.value,
        courseId: courseId.value,
        chapterId: chapterId.value,
        noteTime: noteTime,
        noteContent: noteContent.value
      }
    });

    notes.value.push({ noteTime, noteContent: noteContent.value, isEditing: false });

    isCreatingNote.value = false;
    noteContent.value = '';
  } catch (error) {
    console.error("Error creating note:", error);
  }
};

const formatTime = (seconds) => {
  const minutes = Math.floor(seconds / 60);
  const remainingSeconds = seconds % 60;
  return `${minutes}:${remainingSeconds < 10 ? '0' : ''}${remainingSeconds}`;
};

const isActiveSection = (section) => {
  return currentSection.value.chapterId === section.chapterId;
};

const editNote = (index) => {
  notes.value[index].isEditing = true;
  notes.value[index].editingContent = notes.value[index].noteContent;
};

const saveEdit = async (index) => {
  notes.value[index].noteContent = notes.value[index].editingContent;
  notes.value[index].isEditing = false;
  // 这里如果需要与后端交互保存修改，可添加如下代码
  const noteTime = notes.value[index].noteTime;
  try {
    await axios.put('http://localhost:8081/notes', null, {
      params: {
        userId: userId.value,
        courseId: courseId.value,
        chapterId: chapterId.value,
        noteTime: noteTime,
        noteContent: notes.value[index].noteContent
      }
    });
  } catch (error) {
    console.error("Error updating note:", error);
  }
};

const cancelEdit = (index) => {
  notes.value[index].isEditing = false;
};

const deleteNote = async (index) => {
  notes.value.splice(index, 1);
  // 这里如果需要与后端交互删除笔记，可添加如下代码
  const noteTime = notes.value[index].noteTime;
  console.log(userId.value, courseId.value)
  try {
    await axios.delete('http://localhost:8081/notes', {
      params: {
        userId: userId.value,
        courseId: courseId.value,
        chapterId: chapterId.value,
        noteTime: noteTime
      }
    });
  } catch (error) {
    console.error("Error deleting note:", error);
  }
};

onMounted(() => {
  chapterId.value = route.params.chapterId || '';
  currentSection.value.chapterId = chapterId.value;
  loadCourseData();
});
watch(() => route.params.chapterId, (newChapterId) => {
  chapterId.value = newChapterId;
  loadNotes(courseId.value, chapterId.value); // 重新加载当前章节的笔记
});
</script>

<style scoped>
#section-content {
  display: flex;
  justify-content: space-between;
}

.main-container {
  display: flex;
  width: 100%;
  padding: 50px;

  .back-button{
    margin-top: 40px;
    position: absolute;
  }
}

.video-container {
  width: 70%;
  margin-top: 70px;
  font-size: 30px;
}

.section-list-container {
  width: 30%;
  min-width: 200px;
  font-size: 20px;
  margin-top: 70px;
  overflow-y: auto;
}

.chapter-list {
  padding: 0;
}

.chapter-header {
  cursor: pointer;
  display: flex;
  align-items: center;
  padding-left: 10px;
  font-size: 20px;
  color: #000000;
}

.section-list {
  padding-left: 25px;
}

.section-item {
  cursor: pointer;
  padding: 5px;
  border-bottom: 1px solid #eee;
  display: flex;
  align-items: center;
  font-size: 18px;
  color: #5a5e66;
}

.section-item:hover {
  background-color: #f0f0f0;
}

.section-item.active {
  background-color: #cee4ed;
}

.note-container {
  margin-top: 20px;
}

.note-header {
  display: flex;
  align-items: center;
  margin-bottom: 10px;
}

.note-title {
  font-size: 24px;
  margin: 0;
}

.note-create {
  margin-bottom: 10px;
}

.note-create-actions {
  margin-top: 10px;
}

.note-display {
  background-color: #f9f9f9;
  border: 1px solid #e0e0e0;
  border-radius: 4px;
  padding: 10px;
}

.note-display ul {
  display: flex;
  flex-direction: column;
  /* 让列表项垂直排列 */
  list-style-type: none;
  padding: 0;
  margin: 0;
}

.note-item {
  display: flex;
  align-items: center;
  padding: 8px;
  border-bottom: 1px solid #eee;
  justify-content: flex-start;
  /* 让 note-item 从最左侧开始 */
}

.note-time {
  font-size: 16px;
  /* 增大时间字体大小 */
  color: #888;
  min-width: 60px;
  margin-right: 10px;
}

.note-text {
  width: 500px;
  flex-grow: 1;
  font-size: 18px;
  /* 增大笔记内容字体大小 */
}

.note-actions {
  margin-left: 10px;
}

.note-actions el-button {
  margin-left: 5px;
}
</style>
