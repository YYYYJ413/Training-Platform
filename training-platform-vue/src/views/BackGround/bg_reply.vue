<template>
  <div>
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: '/HomePage' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>问题管理</el-breadcrumb-item>
      <el-breadcrumb-item>问题回复</el-breadcrumb-item>
    </el-breadcrumb>
    <el-card>
      <div class="reply-bar" style="display: flex; justify-content: space-between; align-items: center;">
        <h3>问题回复</h3>
      </div>
      <div v-for="(question, index) in questions" :key="question.questionId" class="question-item">
        <div class="question-info" style="text-align: left;">
          <span>提问人: {{ question.userName }}</span>
          <span>课程名: {{ question.courseName }}</span>
          <span>提问时间: {{ formatDate(question.askTime) }}</span>
        </div>
        <div class="question-content" style="text-align: left;">
          <p>{{ question.questionContent }}</p>
        </div>

        <!-- 如果问题未解决，显示回复按钮 -->
        <div v-if="!question.solve" class="reply-button-container">
          <el-button type="primary" size="mini" @click="openReplyInput(index)">回复</el-button>
        </div>

        <!-- 如果问题已解决，显示修改回复按钮 -->
        <div v-else class="reply-and-delete-container">
          <el-button type="primary" size="mini" @click="editReply(index)">修改回复</el-button>
        </div>

        <!-- 回复输入框 -->
        <div v-if="showReplyInput[index]" class="reply-input-container">
          <el-input
              type="textarea"
              autosize
              placeholder="请输入回复内容"
              v-model="replies[index]"
          ></el-input>
          <el-button type="success" @click="submitReply(index)">确认</el-button>
          <el-button type="info" @click="closeReplyInput(index)">取消</el-button>
        </div>

        <!-- 显示已解决问题的回复内容 -->
        <div v-if="question.solve" class="displayed-reply" style="text-align: left;">
          <span>你的回复：<span v-if="question.questionAnswer">{{ question.questionAnswer }}</span><span v-else>-</span></span>
        </div>
      </div>
    </el-card>
  </div>
</template>

<script setup>
  import { ref, onMounted, nextTick } from 'vue';
  import axios from 'axios';
  import { inject } from 'vue'; // 导入 inject

  const questions = ref([]);
  const replies = ref([]);
  const showReplyInput = ref([]);

  // Fetch questions from API
  const fetchQuestions = async () => {
  try {
  const response = await axios.get('http://localhost:8081/questions/all');
  questions.value = response.data.map(question => ({
  questionId: question.questionId,
  userName: question.userName,
  courseName: question.courseName,
  questionContent: question.questionContent,
  questionAnswer: question.questionAnswer,
  solve: question.solve,
  askTime: question.askTime,
  answerTime: question.answerTime,
  timeCreate: question.timeCreate,
  timeModify: question.timeModify
}));
  replies.value = Array(questions.value.length).fill('');
  showReplyInput.value = Array(questions.value.length).fill(false);
} catch (error) {
  console.error('Error fetching questions:', error);
}
};

const formatDate = (dateString) => {
  const date = new Date(dateString);
  return date.toLocaleString(); // Format date as needed
};

const openReplyInput = (index) => {
  showReplyInput.value[index] = true;
};

const closeReplyInput = (index) => {
  showReplyInput.value[index] = false;
  replies.value[index] = '';
};

  const submitReply = async (index) => {
    const questionId = questions.value[index].questionId;
    const reply = replies.value[index];

    try {
      const response = await axios.put(`http://localhost:8081/questions/answer/${questionId}`, reply);
      if (response.status === 200) {
        questions.value[index].questionAnswer = reply;
        questions.value[index].solve = true;
        showReplyInput.value[index] = false;
        replies.value[index] = '';
        await nextTick();

        // 存储消息到 localStorage
        const message = `您对于《${questions.value[index].courseName}》课程的提问有新回复`;
        localStorage.setItem('newReplyMessage', message);

        // 触发 storage 事件
        window.dispatchEvent(new Event('storage'));
        console.log(`Message stored in localStorage: ${message}`);
      }
    } catch (error) {
      console.error('Error updating reply:', error);
    }
  };

const editReply = (index) => {
  showReplyInput.value[index] = true;
  replies.value[index] = questions.value[index].questionAnswer; // 填充当前回复内容
};

onMounted(fetchQuestions);
defineExpose({ submitReply });
</script>

<style scoped>
.reply-bar {
  margin-bottom: 10px;
}

.question-item {
  border: 1px solid #e0e0e0;
  border-radius: 4px;
  padding: 10px;
  margin-bottom: 10px;
}

.question-info span {
  margin-right: 10px;
}

.question-content {
  margin-top: 5px;
}

.reply-button-container,
.reply-and-delete-container {
  margin-top: 5px;
  text-align: left;
}

.reply-input-container {
  margin-top: 5px;
}

.displayed-reply {
  margin-top: 5px;
  border-left: 2px solid #409eff;
  padding-left: 10px;
}
</style>






