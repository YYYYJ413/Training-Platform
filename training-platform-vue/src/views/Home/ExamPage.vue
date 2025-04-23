<template>
  <div id="exam-page">
    <head-tabar></head-tabar>
    <div class="exam-container">
      <!-- 左侧信息栏 -->
      <div class="left-info">
        <div class="user-info" v-if="!loading && !error">
          <div class="user-basic">
            <el-avatar :size="60" :src="examData.userAvatar" class="user-avatar"></el-avatar>
            <div class="user-details">
              <el-tag color='#fef7ea'>{{examData.userName}}</el-tag>
              <div class="user-meta">
                <span class="department"><i class="bi bi-building"></i> {{examData.department}}</span>
                <span class="user-id"><i class="bi bi-person-circle"></i>{{examData.userNumber}}</span>
              </div>
              <div class="progress-info">
                <span>已答: </span>
                <span class="answered-count">{{answeredQuestions.length}}</span>
                <span>/</span>
                <span class="total-count">{{questions.length}}</span>
              </div>
            </div>
          </div>
        </div>
        <div class="marked-questions" v-if="!loading && !error">
          <h3>标记区</h3>
          <div class="marked-container">
            <div class="marked-scroll">
              <div class="mark-item" v-for="i in questions.length" :key="i" :class="{'marked': isMarked(i)}"
                @click="toggleMark(i)">
                {{i}}
              </div>
            </div>
          </div>
        </div>
        <div class="exam-info" v-if="!loading && !error">
          <h3>{{examData.examName}}</h3>
          <p>提交倒计时：{{formattedTime}}</p>
          <p>开始时间：{{examData.startTime}}</p>
          <p>结束时间：{{examData.endTime}}</p>
        </div>
      </div>

      <!-- 中间题目区域 -->
      <div class="question-area">
        <div class="question-header" v-if="!loading && !error">
          <span>第{{currentQuestion}}题（{{getQuestionType(questions[currentQuestion-1]?.itemType)}}，{{questions[currentQuestion-1]?.itemScore}}分）</span>
        </div>
        <div class="question-content" v-if="!loading && !error">
          <p>题目内容：{{questions[currentQuestion-1]?.itemContent}}</p>

          <template v-if="questions[currentQuestion-1]?.itemType === '0'"> <!-- 单选题 -->
            <el-radio-group v-model="currentAnswers[questions[currentQuestion-1].itemId]"
              @change="handleAnswerChange(questions[currentQuestion-1]?.itemId)">
              <el-radio v-for="(option, index) in questions[currentQuestion-1]?.options" :key="option.optionId"
                :value="option.optionId">
                {{ String.fromCharCode(65 + index) }}. {{ option.optionContent }}
              </el-radio>
            </el-radio-group>
          </template>

          <template v-else-if="questions[currentQuestion-1]?.itemType === '1'"> <!-- 多选题 -->
            <el-checkbox-group v-model="currentAnswers[questions[currentQuestion-1].itemId]"
              @change="handleAnswerChange(questions[currentQuestion-1]?.itemId)">
              <el-checkbox v-for="(option, index) in questions[currentQuestion-1]?.options" :key="option.optionId"
                :label="option.optionId">
                {{ String.fromCharCode(65 + index) }}. {{ option.optionContent }}
              </el-checkbox>
            </el-checkbox-group>
          </template>

          <template v-if="questions[currentQuestion-1]?.itemType === '2'"> <!-- 单选题 -->
            <el-radio-group v-model="currentAnswers[questions[currentQuestion-1].itemId]"
              @change="handleAnswerChange(questions[currentQuestion-1]?.itemId)">
              <el-radio v-for="(option, index) in questions[currentQuestion-1]?.options" :key="option.optionId"
                :value="option.optionId">
                {{ option.optionContent }}
              </el-radio>
            </el-radio-group>
          </template>

          <template v-else-if="questions[currentQuestion-1]?.itemType === '3'">
            <div v-for="(option, index) in questions[currentQuestion-1]?.options" :key="option.optionId">
              <el-input type="textarea" v-model="currentAnswers[`${questions[currentQuestion-1].itemId}-${index}`]"
                @change="handleAnswerChange(questions[currentQuestion-1]?.itemId)" placeholder="请输入答案"></el-input>
            </div>
          </template>

          <template v-else-if="questions[currentQuestion-1]?.itemType === '4'"> <!-- 问答题 -->
            <el-input type="textarea" v-model="currentAnswers[questions[currentQuestion-1].itemId]"
              @change="handleAnswerChange(questions[currentQuestion-1]?.itemId)" placeholder="请写下你的答案"></el-input>
          </template>
        </div>
        <div class="question-navigation">
          <el-button @click="prevQuestion">上一题</el-button>
          <el-button type="primary" @click="nextQuestion">下一题</el-button>
          <el-button type="danger" @click="confirmSubmit">交卷</el-button>
        </div>
      </div>

      <!-- 右侧答题状态栏 -->
      <div class="right-status">
        <div class="status-header">
          <h3>答题状态</h3>
        </div>
        <div class="question-status-group" v-for="(group, index) in questionGroups" :key="index">
          <div class="group-header" :style="{color: group.color}">
            {{group.type}} ({{group.range[0]}}-{{group.range[1]}})
          </div>
          <div class="question-status">
            <div class="status-item" v-for="i in getQuestionsInRange(group.range[0], group.range[1])" :key="i"
              :class="{'answered': isAnswered(i)}" @click="goToQuestion(i)" :style="{borderColor: group.color}">
              {{i}}
            </div>
          </div>
        </div>

        <div class="status-legend">
          <div class="legend-item">
            <span class="unanswered"></span>未作答
          </div>
          <div class="legend-item">
            <span class="answered"></span>已作答
          </div>
          <div class="legend-item">
            <span class="marked"></span>已标记
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import HeadTabar from "../../components/HomeTaber/HeadTabar.vue";
import axios from 'axios';
import {getMaxRetakes, submitExam} from "../../api";
import { mapGetters } from "vuex";

export default {
  name: "ExamPage",
  components: {
    HeadTabar
  },
  data() {
    return {
      retake:1,  //第几次考
      currentQuestion: 1, // 从1开始
      currentAnswers: {}, // 用于存储每个问题的答案
      answeredQuestions: [],
      markedQuestions: [],
      loading: true,
      error: false,
      examData: {
        userAvatar: new URL('../../assets/head8.jpeg', import.meta.url).href,
        examName: "考试测试名称",
        userName: "测试用户",
        department: "技术部",
        userId: "test123",
        remainingTime: "01:30:00",
        startTime: "",
        endTime: ""
      },
      questions: [], // 初始化为空数组
      questionGroups: [], // 初始化为空数组
      timer: null,
      remainingSeconds: 5400, // 默认90分钟(5400秒)
      answerDebounceTimer: null,
      answerDebounceDelay: 1000
    }
  },

  computed: {
    ...mapGetters([
      'userId',
      'userName',
      'userNumber',
      'userGender',
      'contactInfo',
      'department',
      'userImg'
    ]),
    formattedTime() {
      const hours = Math.floor(this.remainingSeconds / 3600);
      const minutes = Math.floor((this.remainingSeconds % 3600) / 60);
      const seconds = this.remainingSeconds % 60;
      return `${hours.toString().padStart(2, '0')}:${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`;
    },
    examId() {
      return this.$route.params.id;
    },
    userId() {
      return this.$store.getters.userId;
    }
  },
  mounted() {
    this.examData = {
      ...this.examData,
      userAvatar: this.userImg || new URL('../../assets/head8.jpeg', import.meta.url).href,
      userName: this.userName,
      department: this.department,
      userId: this.userId,
      userNumber:this.userNumber
    };
    // console.log(this.examId);
    this.questions = [];
    this.fetchRetakeTime();
    this.fetchExamData(this.examId); // 获取examId的考试信息
    this.startTimer();
    this.setExamTimes(); // 设置考试的开始和结束时间
  },
  beforeDestroy() {
    this.clearTimer();
  },
  methods: {
    setExamTimes() {
      const currentTime = new Date();
      this.examData.startTime = currentTime.toLocaleString();
      const endTime = new Date(currentTime.getTime() + this.remainingSeconds * 1000);
      this.examData.endTime = endTime.toLocaleString();
    },
    async fetchRetakeTime() {
      const res = await getMaxRetakes(this.userId, this.examId);
      this.retake = res.data + 1;
      this.$store.commit("setRetakeTime", this.retake);
      // console.log(this.retake);
    },
    fetchExamData(examId) {
      this.loading = true;
      // 获取考试信息
      axios.get(`http://localhost:8081/exam/${examId}`)
          .then(response => {
            const { examName, duration } = response.data;
            this.examData.examName = examName;
            this.remainingSeconds = duration * 60; // 假设duration是以分钟为单位的
            this.examData.remainingTime = this.formattedTime;
            this.loading = false;
            // 获取题目数据
            return this.fetchQuestions(examId);
          })
          .catch(error => {
            console.error("获取考试数据失败:", error);
            this.error = true;
            this.loading = false;
          });
    },
    fetchQuestions(examId) {
      axios.get(`http://localhost:8081/items/${examId}`)
          .then(response => {
            this.questions = response.data.map(item => {
              return {
                itemId: item.itemId,
                itemContent: item.itemContent,
                itemType: item.itemType,
                itemScore: item.itemScore,
                options: item.options.map(option => ({
                  optionId: option.optionId,
                  optionContent: option.optionContent
                }))
              };
            });
            this.loading = false; // 加载完成
            this.generateQuestionGroups(); // 生成题型分组
          })
          .catch(error => {
            console.error("获取题目数据失败:", error);
            this.error = true;
            this.loading = false;
          });
    },
    generateQuestionGroups() {
      const questionTypeOrder = ['0', '1', '2', '3', '4']; // 题型顺序
      const typeCount = {
        '0': { count: 0, color: '#409EFF', type: '单选题', questions: [] },
        '1': { count: 0, color: '#67C23A', type: '多选题', questions: [] },
        '2': { count: 0, color: '#E6A23C', type: '判断题', questions: [] },
        '3': { count: 0, color: 'purple', type: '填空题', questions: [] },
        '4': { count: 0, color: '#F56C6C', type: '问答题', questions: [] }
      };

      // 统计每种题型的数量并存储问题
      this.questions.forEach(question => {
        if (typeCount[question.itemType]) {
          typeCount[question.itemType].count++;
          typeCount[question.itemType].questions.push(question);
        }
      });

      // 生成题型分组和新的题目数组
      this.questionGroups = [];
      const orderedQuestions = []; // 新的题目数组
      let startIndex = 1; // 从1开始

      questionTypeOrder.forEach(type => {
        const group = typeCount[type];
        if (group && group.count > 0) {
          this.questionGroups.push({
            type: group.type,
            range: [startIndex, startIndex + group.count - 1],
            color: group.color
          });

          // 将该组的题目添加到新的题目数组
          orderedQuestions.push(...group.questions);

          startIndex += group.count; // 更新下一个起始索引
        }
      });

      // 更新原始题目数组
      this.questions = orderedQuestions;

    },
    getQuestionType(type) {
      switch (type) {
        case "0": return "单选题";
        case "1": return "多选题";
        case "2": return "判断题";
        case "3": return "填空题";
        case "4": return "问答题";
      }
    },
    isAnswered(index) {
      return this.answeredQuestions.includes(this.questions[index - 1].itemId);
    },

    isMarked(index) {
      return this.markedQuestions.includes(index);
    },
    goToQuestion(index) {
      this.currentQuestion = index;
    },
    prevQuestion() {
      if (this.currentQuestion > 1) {
        this.currentQuestion--;
      }
    },
    nextQuestion() {
      if (this.currentQuestion < this.questions.length) {
        this.currentQuestion++;
      }
    },
    toggleMark(index) {
      const idx = this.markedQuestions.indexOf(index);
      if (idx === -1) {
        this.markedQuestions.push(index);
      } else {
        this.markedQuestions.splice(idx, 1);
      }
    },
    startTimer() {
      this.clearTimer();
      this.timer = setInterval(() => {
        if (this.remainingSeconds > 0) {
          this.remainingSeconds--;
          this.examData.remainingTime = this.formattedTime;
        } else {
          this.clearTimer();
          this.submitExam();
        }
      }, 1000);
    },
    clearTimer() {
      if (this.timer) {
        clearInterval(this.timer);
        this.timer = null;
      }
    },
    handleAnswerChange(questionId) {
      // 处理回答变化
      if (!this.answeredQuestions.includes(questionId)) {
        this.answeredQuestions.push(questionId);
      }
      console.log('当前答案:', this.currentAnswers); // 调试信息
    },


    getQuestionsInRange(start, end) {
      const result = [];
      for (let i = start; i <= end; i++) {
        result.push(i); // 确保这里的索引与题目数组的索引一致
      }
      return result;
    },

    confirmSubmit() {
      this.$confirm('确定要提交试卷吗?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.submitExam();
      }).catch(() => {
        this.$message({
          type: 'info',
          message: '已取消提交'
        });
      });
    },
    submitExam() {
      const answers = [];
      const examId = parseInt(this.examId, 10); 
      const examName = this.examData.examName;
      this.$store.commit("setExamId", examId);
      this.questions.forEach(question => {
        const currentAnswer = this.currentAnswers[question.itemId];
        // 确保判断题的处理逻辑
        if (question.itemType === '2') {
          // 判断题，optionId 是单个值
          answers.push({
            userId:this.userId,
            examId:examId,
            retake: this.retake,
            itemId: question.itemId,
            optionId: currentAnswer, // 这里应该是判断题的答案
            answer: null
          });
          } else if (question.itemType === '0') {
          // 单选题和判断题，optionId 是单个值
          answers.push({
            userId:this.userId, // Fixed userId
            examId:examId, // Fixed examId
            retake: this.retake, // Assuming retake is 1 for now
            itemId: question.itemId, // Question ID
            optionId: currentAnswer, // 单选题或判断题的选项ID
            answer: null // 没有文本答案
          });
        } else if (question.itemType === '1') {
          // 多选题，optionId 是一个数组
          currentAnswer.forEach(optionId => {
            answers.push({
              userId:this.userId,
              examId:examId,
              retake: this.retake, 
              itemId: question.itemId, // Question ID
              optionId: optionId, // 多选题的选项ID
              answer: null // 没有文本答案
            });
          });
              } else if (question.itemType === '3') { // 填空题
                // 遍历每个空的答案
                question.options.forEach((option, index) => {
                  const answerKey = `${question.itemId}-${index}`;
                  const answerContent = this.currentAnswers[answerKey];
                  if (answerContent) {
                    answers.push({
                      userId:this.userId,
                      examId:examId,
                      retake: this.retake,
                      itemId: question.itemId,
                      optionId: 0,
                      answer: answerContent
                    });
                  }
                });
              } else if (question.itemType === '4') { // 问答题
                answers.push({
                  userId: this.userId,
                  examId: examId,
                  retake: this.retake,
                  itemId: question.itemId,
                  optionId: 0,
                  answer: currentAnswer
                });

        }
      });

      // Send the collected answers to the backend
      const promises = answers.map(answer => {
        return axios.post('http://localhost:8081/uexam/add', answer);
      });

      // Wait for all requests to finish
      Promise.all(promises)
          .then(responses => {
            this.$message.success('试卷提交成功！');
            this.$router.push(`/exam-result/${examId}`); // Navigate to results page
          })
          .catch(error => {
            console.error("提交试卷失败:", error);
            this.$message.error('提交失败，请重试！');
          });
    }



  }
}
</script>

<style scoped>
/* 添加您的样式 */
#exam-page {
  height: 100vh;
  padding: 20px;
  background: #ebeef5;
  margin: 70px auto 0;
}

.exam-container {
  display: flex;
  width: 1300px;
  margin: 0 auto;
  gap: 20px;
}

.left-info {
  width: 250px;
  padding: 1px;
  border-radius: 8px;
}

.user-info {
  background: #fff;
  border-radius: 8px;
  padding: 15px;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
  margin-bottom: 20px;
}

.user-basic {
  display: flex;
  align-items: center;
}

.user-avatar {
  margin-right: 15px;
  border: 2px solid #fff;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.user-details {
  flex: 1;
  color: #727a81;
  font-weight: bold;
}

.user-meta {
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
  margin-bottom: 10px;
}

.user-meta span {
  display: flex;
  align-items: center;
  font-size: 12px;
  color: #1499ff;
}

.user-meta i {
  margin-right: 5px;
  color: #409eff;
}

.progress-info {
  margin-top: 10px;
  font-size: 14px;
}

.answered-count {
  color: #67c23a;
  font-weight: bold;
}

.total-count {
  color: #909399;
}

.exam-info {
  background: #fff;
  border-radius: 8px;
  padding: 15px;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
  margin-bottom: 20px;
}

.marked-questions {
  background: #fff;
  border-radius: 8px;
  padding: 15px;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
  margin-bottom: 20px;
}

.marked-container {
  width: 100%;
  overflow-x: auto;
  padding: 5px 0;
}

.marked-scroll {
  display: flex;
  gap: 8px;
  width: max-content;
}

.mark-item {
  width: 30px;
  height: 30px;
  display: flex;
  align-items: center;
  justify-content: center;
  border: 1px solid #ddd;
  border-radius: 4px;
  cursor: pointer;
  background: white;
}

.mark-item.marked {
  background: #e6a23c;
  color: white;
  border-color: #e6a23c;
}

.question-area {
  flex: 1;
  background: #fff;
  padding: 20px;
  border-radius: 8px;
}

.right-status {
  width: 280px;
  background: #fff;
  padding: 15px;
  border-radius: 8px;
}

.question-status-container {
  max-height: 700px;
  overflow-y: auto;
}

.question-status-group {
  margin-bottom: 15px;
}

.group-header {
  font-weight: bold;
  margin-bottom: 8px;
  font-size: 14px;
}

.question-status {
  display: grid;
  grid-template-columns: repeat(5, 1fr);
  gap: 8px;
}

.status-item {
  width: 30px;
  height: 30px;
  display: flex;
  align-items: center;
  justify-content: center;
  border: 1px solid;
  border-radius: 4px;
  cursor: pointer;
  background: white;
}

.status-item.answered {
  color: white;
}

.status-item.marked {
  border-width: 2px;
}

.status-legend {
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.legend-item {
  display: flex;
  align-items: center;
  gap: 5px;
}

.legend-item span {
  display: inline-block;
  width: 15px;
  height: 15px;
  border-radius: 3px;
}

.unanswered {
  background: white;
  border: 1px solid #ddd;
}

.answered {
  background: #67c23a;
}

.marked {
  border: 2px solid #e6a23c;
}

.question-navigation {
  margin-top: 20px;
  display: flex;
  justify-content: space-between;
}

.preview-btn {
  margin-left: auto;
}
.question-header{
  text-decoration:underline;
}
.question-content{
  margin-top: 10px;
  /* font-size: 18px; */
  
}

</style>
