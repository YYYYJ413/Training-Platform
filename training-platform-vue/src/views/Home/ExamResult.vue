<template>
  <div id="exam-result">
    <head-tabar></head-tabar>
    <div class="result-container">
      <div class="result-header">
        <h2>{{ examData.examName }} - 考试结果</h2>
        <div class="score-summary">
          <span>总得分: {{ totalScore }}分</span>
          <span v-if="!canRetake">正确率: {{ correctRate }}%</span>
        </div>
      </div>

      <div class="result-content">
        <div class="question-result" v-for="(question, index) in groupedQuestions" :key="question.id">
          <div class="question-header">
            <span>第{{ index + 1 }}题（{{ getQuestionType(question.itemType) }}，{{ question.itemScore }}分）</span>
            <span class="user-score" :class="{
              'correct': question.userScore === question.itemScore,
              'partial': question.userScore < question.itemScore && question.userScore > 0,
              'wrong': question.userScore === 0
            }">
              得分: {{ question.userScore }}分
            </span>
          </div>

          <div class="question-content">
            <p>题目内容：{{ question.itemContent }}</p>

            <div class="answer-section">
              <div class="user-answer">
                <span>你的答案: </span>
                <span>{{ formatUserAnswer(question.userAnswers) }}</span>
              </div>

              <div class="correct-answer" v-if="!canRetake">
                <span>正确答案: </span>
                <span>{{ question.correctAnswer }}</span>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="result-footer">
        <el-button type="primary" @click="goBack" v-if="canRetake">
          返回重考
        </el-button>
        <el-button type="primary" @click="goHome">
          返回首页
        </el-button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive, computed, onMounted } from 'vue';
import axios from 'axios';
import HeadTabar from "../../components/HomeTaber/HeadTabar.vue";
import { useStore } from 'vuex';
import { useRoute, useRouter } from 'vue-router';
import { fetchRemaingingTakeTime, getExamById, getMaxRetakes } from '../../api';

const examData = ref({});
const store = useStore();
const router = useRouter();
const route = useRoute();
const groupedQuestions = ref([]);
const userId = computed(() => store.getters.userId);
const examId = computed(() => store.getters.examId);
const retake = computed(() => store.getters.retakeTime);
const canRetake = ref();

// 计算总分
const totalScore = computed(() => {
  return groupedQuestions.value.reduce((sum, q) => sum + q.userScore, 0);
});

// 计算正确率
const correctRate = computed(() => {
  const correctCount = groupedQuestions.value.filter(
    q => q.userAnswers.every(ans => ans === q.correctAnswer)
  ).length;
  return Math.round((correctCount / groupedQuestions.value.length) * 100);
});

const fetchUanswers = async () => {
  try {
    const response = await axios.get(`http://localhost:8081/filter`, {
      params: {
        userId: userId.value,
        examId: examId.value,
        retake: retake.value
      }
    });
    const res = await getExamById(examId.value);
    examData.value = res.data;
    const groupedData = {};
    response.data.forEach(item => {
      if (!groupedData[item.itemId]) {
        groupedData[item.itemId] = {
          id: item.itemId,
          itemType: item.itemType,
          itemScore: item.itemScore,
          itemContent: item.itemContent,
          userAnswers: [],
          judgeAnswers: [],
          userScore: 0
        };
      }
      groupedData[item.itemId].userAnswers.push(item.optionId === 0 ? item.answer : item.optionContent);
      groupedData[item.itemId].judgeAnswers.push(item.optionId === 0 ? item.answer : String(item.optionId));
    });
    groupedQuestions.value = Object.values(groupedData).sort((a, b) => a.id - b.id);
    await fetchCorrectAnswers();
  } catch (error) {
    console.error("Error fetching answers:", error);
  }
};

const fetchCorrectAnswers = async () => {
  const fetchPromises = groupedQuestions.value.map(async question => {
    try {
      // console.log(question.id);
      const response = await axios.get(`http://localhost:8081/item-option/correct/${question.id}`);

      // 提取所有 optionId 并存储为数组
      const correctAnswerIds = response.data.map(option => option.optionId.toString());
      question.correctAnswer = correctAnswerIds;
      // console.log(correctAnswerIds, question.judgeAnswers);

      //填空/主观
      if (question.itemType === "3" || question.itemType === "4") {
        const correctAnswers = response.data.map(option => option.optionAnswer).join("; ");
        question.correctAnswer = correctAnswers;
      } else {
        const correctAnswers = response.data.map(option => option.optionContent).join("; ");
        question.correctAnswer = correctAnswers;
      }
      const userAnswer = question.judgeAnswers;
      question.userScore = calculateScore(userAnswer, correctAnswerIds || [], question.itemScore);
    } catch (error) {
      console.error(`Error fetching correct answer for question ${question.id}:`, error);
    }
  });
  await Promise.all(fetchPromises)
    .then(() => {
      uploadScore(); // 上传分数
    })
    .catch(error => {
      console.error("Error fetching correct answers:", error);
    });
};

const calculateScore = (userAnswers, correctAnswers, fullScore) => {
  const userAnswersSet = new Set(userAnswers);
  const correctAnswersSet = new Set(correctAnswers);
  if (userAnswersSet.size === correctAnswersSet.size && [...userAnswersSet].every(answer => correctAnswersSet.has(answer))) {
    return fullScore;
  }
  return 0;
};

const formatUserAnswer = (answers) => {
  return answers.join(', ') || '未作答';
};

const getQuestionType = (itemType) => {
  const typeMap = {
    0: '单选题',
    1: '多选题',
    2: '判断题',
    3: '填空题',
    4: '问答题'
  };
  return typeMap[itemType] || '未知题型';
};

const goBack = () => {
  router.go(-1);
};

const goHome = () => {
  router.push('/studycenter/3')
};

const uploadScore = async () => {
  const scoreData = {
    userId: userId.value,
    examId: examId.value,
    objectScore: totalScore.value, // 这里可以根据需要计算 objectScore
    subjectScore: 0, // 需要根据实际情况计算
    userScore: totalScore.value,
    retake: retake.value,
    timeCreate: new Date(),
    timeModify: new Date()
  };

  try {
    const response = await axios.post(`http://localhost:8081/scores`, scoreData);
    console.log("Score uploaded successfully:", response.data);
    getCanRetake();
  } catch (error) {
    console.error("Error uploading score:", error);
  }
};

const getCanRetake = async () => {
  const res=await fetchRemaingingTakeTime(userId.value, examId.value);
  const times = res.data;
  console.log('剩余考试次数', times);
  if (times>0) {
    canRetake.value = true;
  } else {
    canRetake.value = false;
  }
}
onMounted(async () => {
  // console.log(canRetake.value);
  await fetchUanswers();
  // await uploadScore(); // 在获取答案后上传分数
});
</script>



<style scoped>
#exam-result {
  height: 100%;
  padding: 20px;
  background: #ebeef5;
  margin: 70px auto 0;
}

.result-container {
  width: 1200px;
  margin: 0 auto;
  background: #fff;
  border-radius: 8px;
  padding: 20px;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
}

.result-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
  padding-bottom: 10px;
  border-bottom: 1px solid #ebeef5;
}

.score-summary {
  display: flex;
  gap: 20px;
}

.score-summary span {
  font-size: 16px;
  font-weight: bold;
}

.question-result {
  margin-bottom: 20px;
  padding: 15px;
  border-radius: 4px;
  background: #f5f7fa;
}

.question-header {
  display: flex;
  justify-content: space-between;
  margin-bottom: 10px;
}

.user-score {
  font-weight: bold;
}

.user-score.correct {
  color: #67c23a;
}

.user-score.partial {
  color: #e6a23c;
}

.user-score.wrong {
  color: #f56c6c;
}

.answer-section {
  margin-top: 10px;
  padding: 10px;
  background: #fff;
  border-radius: 4px;
}

.user-answer,
.correct-answer {
  margin: 5px 0;
}

.result-footer {
  margin-top: 20px;
  display: flex;
  justify-content: flex-end;
  gap: 10px;
}
</style>
