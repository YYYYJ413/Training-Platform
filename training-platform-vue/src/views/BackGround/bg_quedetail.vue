<template>
  <div>
    <el-card>
      <el-row>
        <el-col>
          <span style="margin-right: 10px;">当前题库：{{ bankName }}</span>
          <el-button type="primary" @click="createQuestionVisible = true">创建题目</el-button>
          <el-button type="success" @click="backtoBank">返回题库</el-button>
        </el-col>
      </el-row>
      <br>
      <el-table :data="questionList" border stripe>
        <el-table-column prop="itemContent" label="题目"></el-table-column>
        <el-table-column prop="itemDifficulty" label="难度" width="150px">
          <template #default="scope">
            <template v-for="(star, index) in 5">
              <span :class="{ 'star': index < scope.row.itemDifficulty, 'unfilled': index >= scope.row.difficulty }">
                {{ index < scope.row.itemDifficulty ? '★' : '☆' }} </span>
            </template>
          </template>
        </el-table-column>
        <el-table-column label="类别" width="100px">
          <template #default="scope">
            {{ getQuestionType(scope.row.itemType).simpleName }}
          </template>
        </el-table-column>
        <el-table-column label="操作" width="250px">
          <template #default="scope">
            <el-button type="primary" @click="editQuestion(scope.row)">编辑</el-button>
            <el-button type="danger" @click="deleteQuestion(scope.row.itemId)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
      <!-- 分页 -->
      <el-pagination @size-change="handleSizeChange" @current-change="handleCurrentChange" :current-page="page.pagenum"
        :page-sizes="[3, 5, 10, 15]" :page-size="page.pagesize" layout="total,sizes,prev,pager,next" :total="page.total"
        background style="margin: 15px;float:right"></el-pagination>
    </el-card>

    <!-- 创建题目对话框 -->
    <el-dialog v-model="createQuestionVisible" title="创建题目" width="750px">
      <el-form :model="postForm">
        <el-form-item label="题目类型" prop="qutype">
          <el-select v-model="postForm.qutype" style="width: 200px;" :disabled="quTypeDisabled"
            @change="handleTypeChange">
            <el-option v-for="item in quTypes" :key="item.value" :label="item.label" :value="item.value" />
          </el-select>
        </el-form-item>
        <el-form-item label="难度等级" prop="difficulty">
          <el-input-number v-model.number="postForm.difficulty" :min="1" :max="5" />
        </el-form-item>
        <el-form-item label="题目分值" prop="itemScore">
          <el-input-number v-model.number="postForm.itemScore" :min="1" :max="50" />
        </el-form-item>
        <el-form-item label="题目内容" prop="content">
          <el-input v-model="postForm.content" type="textarea" />
        </el-form-item>
      </el-form>
      <el-button type="primary" size="small" style="float: left;" plain @click="handleAdd">
        <el-icon>
          <Plus />
        </el-icon>
        添加
      </el-button>
      <el-table :data="postForm.answerList" :border="true" style="width: 100%;">
        <el-table-column label="是否答案" width="120" align="center">
          <template #default="scope">
            <el-checkbox v-model="scope.row.isRight">答案</el-checkbox>
          </template>
        </el-table-column>

        <el-table-column label="选项内容">
          <template #default="scope">
            <el-input v-model="scope.row.content" type="textarea" />
          </template>
        </el-table-column>

        <el-table-column label="操作" align="center" width="100px">
          <template #default="scope">
            <el-button type="danger" circle @click="removeItem(scope.$index)">
              <el-icon>
                <Delete />
              </el-icon>
            </el-button>
          </template>
        </el-table-column>
      </el-table>
      <template #footer>
        <el-button @click="createQuestionVisible = false">取消</el-button>
        <el-button type="primary" @click="createQuestion">确认</el-button>
      </template>
    </el-dialog>

    <!-- 编辑题目对话框 -->
    <el-dialog v-model="editQuestionVisible" title="编辑题目" width="750px">
      <el-form>
        <el-form-item label="题目类型" prop="qutype">
          <el-select v-model="editForm.qutype" style="width: 200px;" :disabled="quTypeDisabled"
            @change="handleTypeChange">
            <el-option v-for="item in quTypes" :key="item.value" :label="item.label" :value="item.value" />
          </el-select>
        </el-form-item>
        <el-form-item label="难度等级" prop="difficulty">
          <el-input-number v-model.number="editForm.difficulty" :min="1" :max="5" />
        </el-form-item>
        <el-form-item label="题目分值" prop="difficulty">
          <el-input-number v-model.number="editForm.itemScore" :min="1" :max="50" />
        </el-form-item>
        <el-form-item label="题目内容" prop="content">
          <el-input v-model="editForm.content" type="textarea" />
        </el-form-item>
      </el-form>
      <el-button type="primary" size="small" style="float: left;" plain @click="handleEditAdd">
        <el-icon>
          <Plus />
        </el-icon>
        添加
      </el-button>
      <el-table :data="editForm.answerList" :border="true" style="width: 100%;">
        <el-table-column label="是否答案" width="120" align="center">
          <template #default="scope">
            <el-checkbox v-model="scope.row.isRight">答案</el-checkbox>
          </template>
        </el-table-column>

        <el-table-column label="选项内容">
          <template #default="scope">
            <el-input v-model="scope.row.content" type="textarea" />
          </template>
        </el-table-column>

        <el-table-column label="操作" align="center" width="100px">
          <template #default="scope">
            <el-button type="danger" circle @click="removeEditItem(scope.$index)">
              <el-icon>
                <Delete />
              </el-icon>
            </el-button>
          </template>
        </el-table-column>
      </el-table>
      <template #footer>
        <el-button @click="editQuestionVisible = false">取消</el-button>
        <el-button type="primary" @click="saveEditQuestion">确认</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script>
import { ref, reactive, onMounted, computed, watch } from 'vue';
import { ElMessage, ElMessageBox } from 'element-plus';
import { addItemBank, deleteItemBank, getBankQueList, updateItemBank } from '../../api';
import { useRoute, useRouter } from 'vue-router';
import { getQuestionType } from '../../enums/questionType';
import { useStore } from 'vuex';

export default {
  setup() {
    const questionData = ref([]); //所有数据
    const route = useRoute();
    const router = useRouter();
    const store = useStore();
    const bankId = ref(route.params.bankId);
    const bankName = store.getters.bankName;
    const page = ref({
      pagenum: 1,
      pagesize: 10,
      total:0
    })

    const quTypeDisabled = ref(false);
    const quTypes = [{
      value: 0,
      label: '单选题'
    }, {
      value: 1,
      label: '多选题'
    },
    {
      value: 2,
      label: '判断题'
    },
    {
      value: 3,
      label: '填空题'
    },
    {
      value: 4,
      label: '主观题'
    }
    ];

    const questionList = computed(() => {
      const start = (page.value.pagenum - 1) * page.value.pagesize;
      const end = start + page.value.pagesize;
      return questionData.value.slice(start, end);
    });

    const createQuestionVisible = ref(false);
    const postForm = reactive({
      content: '',
      difficulty: 1,
      answerList: [],
      qutype: '',
      itemScore:5
    });

    const editQuestionVisible = ref(false);
    const editForm = reactive({
      id: null,
      content: '',
      difficulty: 1,
      qutype: '',
      answerList: [],
      itemScore:0
    });

    const loadQuestionData = () => {
      getBankQueList(bankId.value).then(res => {
        // console.log(res.data);
        questionData.value = res.data.data;
        page.value.total = questionData.value.length;
      })
    };

    const handleTypeChange = (v) => {
      postForm.answerList = []
      if (v === 2) {
        postForm.answerList.push({ isRight: true, content: '正确' })
        postForm.answerList.push({ isRight: false, content: '错误' })
      }

      if (v === 0 || v === 1) {
        postForm.answerList.push({ isRight: false, content: '' })
        postForm.answerList.push({ isRight: false, content: '' })
        postForm.answerList.push({ isRight: false, content: '' })
        postForm.answerList.push({ isRight: false, content: '' })
      }

      if (v === 3 || v === 4) {
        postForm.answerList.push({ isRight: false, content: '' })
      }
    }

    const handleAdd = () => {
      postForm.answerList.push({ isRight: false, content: '' })
    };
    const handleEditAdd = () => {
      editForm.answerList.push({ isRight: false, content: '' })
    };

    const removeItem = (index) => {
      postForm.answerList.splice(index, 1)
    };
    const removeEditItem = (index) => {
      editForm.answerList.splice(index, 1);
    };

    const createQuestion = () => {
      let rightCount = 0
      postForm.answerList.forEach(function (item) {
        if (item.isRight) {
          rightCount += 1
        }
      })
      // console.log(rightCount,postForm.qutype);
      if (postForm.qutype === 0) {
        if (rightCount !== 1) {
          ElMessage.error('单选题只能有一个正确答案')
          return
        }
      }
      if (postForm.qutype === 1) {
        if (rightCount < 2) {
          ElMessage.error('多选题至少有两个正确答案')
          return
        }
      }
      if (postForm.qutype === 2) {
        if (rightCount !== 1) {
          ElMessage.error('判断题只能有一个正确项')

          return
        }
      }
      // console.log(postForm,postForm.answerList);
      const newQuestion = {
        itemContent: postForm.content,
        itemDifficulty: postForm.difficulty,
        itemType: postForm.qutype,
        bankId: bankId.value,
        itemScore:postForm.itemScore,
        itemOptions: postForm.answerList.map(option => ({
          optionContent: option.content,
          optionAnswer: option.isRight ? 1 : null
        }))
      };
      console.log(newQuestion);
      addItemBank(newQuestion).then(res => {
        if (res.data.code === 0) {
          ElMessage.success('题目创建成功');
          loadQuestionData();
          createQuestionVisible.value = false;
        } else {
          ElMessage.error('题目创建失败');
        }
      })
    };

    // 题目类型映射
    const questionTypeMap = {
      'SINGLE_CHOICE': 0,
      'MULTIPLE_CHOICE': 1,
      'JUDGEMENT': 2,
      'FILL_BLANK': 3,
      'SUBJECTIVE': 4
    };

    const editQuestion = (question) => {
      console.log(question);
      editForm.id = question.itemId;
      editForm.content = question.itemContent;
      editForm.difficulty = question.itemDifficulty;
      editForm.qutype = questionTypeMap[question.itemType] || 0;
      editForm.itemScore = question.itemScore;
      // 转换选项数据格式
      editForm.answerList = question.itemOptions.map(option => ({
        optionId: option.optionId, // 保留选项ID用于更新
        isRight: option.optionAnswer === "1", // 注意这里是字符串"1"
        content: option.optionContent,
      }));
      // console.log(editForm);
      editQuestionVisible.value = true;
    };

    const saveEditQuestion = () => {
      let rightCount = 0;

      editForm.answerList.forEach(item => {
        if (item.isRight) {
          rightCount += 1;
        }
      });

      // 验证答案数量
      if (editForm.qutype === 0 && rightCount !== 1) {
        ElMessage.error('单选题只能有一个正确答案');
        return;
      }
      if (editForm.qutype === 1 && rightCount < 2) {
        ElMessage.error('多选题至少有两个正确答案');
        return;
      }
      if (editForm.qutype === 2 && rightCount !== 1) {
        ElMessage.error('判断题只能有一个正确项');
        return;
      }

      const updatedQuestion = {
        itemId: editForm.id,
        itemContent: editForm.content,
        itemType: Object.keys(questionTypeMap).find(key => questionTypeMap[key] === editForm.qutype) || 'SINGAL_CHOICE',
        itemDifficulty: editForm.difficulty,
        itemScore:editForm.itemScore,
        bankId: bankId.value,
        itemOptions: editForm.answerList.map(option => ({
          optionId: option.optionId, // 保留原optionId
          optionContent: option.content,
          optionAnswer: option.isRight ? "1" : null, // 注意这里是字符串"1"
        }))
      };
      // console.log(updatedQuestion);
      updateItemBank(updatedQuestion).then(res => {
        if (res.data.code === 0) {
          ElMessage.success('题目更新成功');
          editQuestionVisible.value = false;
          loadQuestionData();
        } else {
          ElMessage.error(res.data.msg || '题目更新失败');
        }
      }).catch(err => {
        ElMessage.error('题目更新失败');
      })
      
    };

    const deleteQuestion = (id) => {
      // console.log(id);
      ElMessageBox.confirm('确定要删除该题目吗？', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(async () => {
        const response =await deleteItemBank(id);
        if (response.data.code === 0) {
          ElMessage.success('题目删除成功');
          loadQuestionData();
        } else {
          ElMessage.error('题目删除失败');
        }
      }).catch(() => {
        // 用户取消操作时的处理，这里可以不做额外操作
      });
    };

    const backtoBank = () => {
      router.push('/bg_home/quebank');
    }

    watch(
      () => route.params.bankId,
      (newId) => {
        bankId.value = newId;
        loadQuestionData(); // 参数变化时重新加载数据
      }
    );

    const handleSizeChange = (val) => {
      page.value.pagesize = val;
    };

    const handleCurrentChange = (val) => {
      page.value.pagenum = val;
    };

    onMounted(() => {
      // console.log(bankId);
      loadQuestionData();
    });

    return {
      handleSizeChange,
      handleCurrentChange,
      questionList,
      page,
      createQuestionVisible,
      postForm,
      editForm,
      bankName,
      editQuestionVisible,
      createQuestion,
      editQuestion,
      saveEditQuestion,
      deleteQuestion,
      loadQuestionData,
      getQuestionType,
      backtoBank,
      handleAdd,
      handleEditAdd,
      removeItem,
      removeEditItem,
      quTypes,
      quTypeDisabled,
      handleTypeChange,
    };
  }
};
</script>

<style scoped>
.star {
  color: #f90;
}

.unfilled {
  color: #ccc;
}
</style>

<style scoped>
.star {
  color: #f90;
}

.unfilled {
  color: #ccc;
}
</style>