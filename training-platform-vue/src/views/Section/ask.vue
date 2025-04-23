<template>
  <div id="task" style="width: 1100px;">
    <!-- 未回复部分 -->
    <div style="display: flex; justify-content: space-between; align-items: center;">
      <h3 style="border-left: 5px solid #9b9b9b; margin: 0;">
        &nbsp;未回复({{ count2 }})
      </h3>
      <div>
        <button style="background: none; border: none; color: blue; cursor: pointer;" @click="showAddUnrepliedForm">添加</button>
        <button style="background: none; border: none; color: red; cursor: pointer;" @click="deleteSelectedQuestions">删除</button>
      </div>
    </div>
    <ul class="question-list">
      <li v-for="(question, index) in unrepliedQuestions" :key="question.id" class="unreplied-question-item">
        <input type="checkbox" v-model="question.isSelected">
        {{ index + 1 }}. 问题：{{ question.title }}
      </li>
    </ul>
    <div v-if="showAddUnreplied" class="add-unreplied-form">
      <input type="text" v-model="newUnrepliedTitle" placeholder="请输入问题">
      <button @click="addUnrepliedQuestion">确认添加</button>
      <button @click="hideAddUnrepliedForm">取消</button>
    </div>

    <!-- 已回复部分 -->
    <div style="border-bottom: 2px solid #b3b3b3; display: flex; justify-content: space-between; align-items: center;">
      <h3 style="border-left: 5px solid #7b9e31; margin: 0;">
        &nbsp;已回复({{ count1 }})
      </h3>
    </div>
    <ul class="question-list">
      <li v-for="(question, index) in repliedQuestions" :key="question.id" class="replied-question-item">
        <input type="checkbox" v-model="question.isSelected">
        <span class="replied-question-item-question">{{ index + 1 }}. 问题：{{ question.title }}</span>
        <span class="replied-question-item-answer">回复：{{ question.reply }}</span>
      </li>
    </ul>
  </div>
</template>

<script>
export default {
  name: "Task",
  data() {
    return {
      count1: 0,
      count2: 0,
      repliedQuestions: [],
      unrepliedQuestions: [],
      showAddUnreplied: false,
      newUnrepliedTitle: ''
    };
  },
  mounted() {
    this.fetchQuestions();
  },
  methods: {
    async fetchQuestions() {
      try {
        const userId = this.$store.getters.userId;
        const courseId = this.$route.params.id;
        const params = new URLSearchParams({ userId, courseId });
        const response = await fetch(`http://localhost:8081/questions?${params.toString()}`);
        const data = await response.json();

        // 假设data是一个数组，包含多个问题对象
        if (Array.isArray(data)) {
          this.repliedQuestions = [];
          this.unrepliedQuestions = [];
          this.count1 = 0;
          this.count2 = 0;

          data.forEach(question => {
            if (question.solve === false) {
              this.unrepliedQuestions.push({
                id: question.questionId,
                title: question.questionContent,
                isSelected: false
              });
              this.count2++;
            } else {
              this.repliedQuestions.push({
                id: question.questionId,
                title: question.questionContent,
                reply: question.questionAnswer,
                isSelected: false
              });
              this.count1++;
            }
          });
        }
      } catch (error) {
        console.error("获取问题失败:", error);
      }
    },
    async deleteSelectedQuestions() {
      const idsToDelete = [
        ...this.repliedQuestions.filter(q => q.isSelected).map(q => q.id),
        ...this.unrepliedQuestions.filter(q => q.isSelected).map(q => q.id)
      ];

      if (idsToDelete.length === 0) {
        alert("请至少选择一个问题进行删除");
        return;
      }

      try {
        await Promise.all(idsToDelete.map(id => this.deleteQuestion(id)));
        await this.fetchQuestions(); // Refresh the list after deletion
      } catch (error) {
        console.error("删除问题失败:", error);
      }
    },
    async deleteQuestion(questionId) {
      const response = await fetch(`http://localhost:8081/questions/${questionId}`, {
        method: 'DELETE'
      });
      if (!response.ok) {
        throw new Error(`Error deleting question with id ${questionId}`);
      }
    },
    showAddUnrepliedForm() {
      this.showAddUnreplied = true;
    },
    hideAddUnrepliedForm() {
      this.showAddUnreplied = false;
      this.newUnrepliedTitle = '';
    },
    async addUnrepliedQuestion() {
      if (this.newUnrepliedTitle) {
        const userId = this.$store.getters.userId;
        const courseId = this.$route.params.id;
        try {
          await this.createQuestion(userId, courseId, this.newUnrepliedTitle);
          await this.fetchQuestions(); // Refresh the list after adding
          this.showAddUnreplied = false;
          this.newUnrepliedTitle = '';
        } catch (error) {
          console.error("添加问题失败:", error);
        }
      }
    },
    async createQuestion(userId, courseId, questionContent) {
      const response = await fetch(`http://localhost:8081/questions?userId=${userId}&courseId=${courseId}&questionContent=${encodeURIComponent(questionContent)}`, {
        method: 'POST'
      });
      if (!response.ok) {
        throw new Error("Error creating question");
      }
    }
  }
};
</script>

<style scoped>
#task {
  text-align: left;
}

.question-list {
  list-style-type: none;
  padding: 0;
  margin-left: 0;
}

.replied-question-item {
  margin-bottom: 1em;
  border: 1px solid #ddd;
  padding: 10px;
  display: block;
  width: 100%;
}

.replied-question-item-question {
  display: block;
  margin-bottom: 5px;
}

.replied-question-item-answer {
  display: block;
  background-color: #f0f9eb;
  padding: 5px;
}

.unreplied-question-item {
  background-color: #fcf4e6;
  border: 1px solid #ddd;
  padding: 10px;
  display: block;
  width: 100%;
}

.add-replied-form,
.add-unreplied-form {
  margin-top: 10px;
}

.add-unreplied-form input {
  margin-right: 5px;
}
</style>