<template>
  <div class="exam-list">
    <el-breadcrumb>
      <el-breadcrumb-item :to="{ path: '/HomePage' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>考试管理</el-breadcrumb-item>
      <el-breadcrumb-item>考试列表</el-breadcrumb-item>
    </el-breadcrumb>
    <el-card>
      <el-row :gutter="20">
        <el-col :span="20">
          <div style="display: flex; gap: 15px;">
            <span style="white-space: nowrap;">考试名称</span>
            <el-input v-model="queryInfo.examName" placeholder="请输入考试名称" style="width: 100%;">
            </el-input>
            <span style="white-space: nowrap;">试卷分类</span>
            <el-select v-model="queryInfo.paperId" placeholder="请选择试卷" style="width: 100%;">
              <el-option v-for="item in paperOptions" :key="item.value" :value="item.value"
                :label="item.label"></el-option>
            </el-select>
            <span style="white-space: nowrap;">课程分类</span>
            <el-select v-model="queryInfo.courseId" placeholder="请选择课程" @change="loadExamsByCourse">
              <el-option v-for="item in courseOptions" :key="item.value" :value="item.value"
                :label="item.label"></el-option>
            </el-select>
            <el-button type="primary" @click="resetQuery">重置</el-button>
          </div>
        </el-col>
      </el-row>
      <!-- //空一行 -->
      <el-row :gutter="20">
        <el-col :span="24" style="margin: 10px;">
          <div>
            <el-button type="primary" @click="showAddExamDialog = true" style="float:left">添加考试</el-button>
            <el-button @click="downloadExams" style="float: right;margin-right: 15px;">下载</el-button>
          </div>
        </el-col>
      </el-row>
      <el-row>
        <el-col>
          <el-table :data="paginatedExams" style="width: 100%" border>
            <el-table-column type="selection" width="55"></el-table-column>
            <el-table-column prop="id" label="序号" width="80"></el-table-column>
            <el-table-column prop="name" label="考试名称" width="170"></el-table-column>
            <el-table-column prop="courseName" label="课程名称" width="170"></el-table-column>
            <el-table-column prop="paperName" label="试卷名称" width="170"></el-table-column>
            <el-table-column prop="retakeAllow" label="允许重考" width="85">
              <template #default="scope">
                <el-tag :type="scope.row.retakeAllow ? 'success' : 'danger'">
                  {{ scope.row.retakeAllow ? '是' : '否' }}
                </el-tag>
              </template>
            </el-table-column>
            <el-table-column prop="duration" label="考试时长(分钟)" width="120"></el-table-column>
            <el-table-column prop="passScore" label="及格分数" width="100"></el-table-column>
            <el-table-column prop="createTime" label="创建时间" width="180"></el-table-column>
            <el-table-column prop="updateTime" label="更新时间" width="180"></el-table-column>
            <el-table-column label="操作" width="150" fixed="right">
              <template #default="scope">
                <el-button size="small" type="warning" @click="EditExam(scope.row)">编辑</el-button>
                <el-button size="small" type="danger" @click="DeleteExam(scope.row.id)">删除</el-button>
                <el-button size="small" style="margin-left: 0;width: 87%;" @click="ViewStus(scope.row)">考生情况</el-button>
              </template>
            </el-table-column>
          </el-table>
        </el-col>
      </el-row>
      <!-- 列表 -->

      <!-- 列表分页 -->
      <div class="pagination-container">
        <el-pagination @current-change="handleCurrentChange" @size-change="handleSizeChange"
          :current-page="page.pagenum" :page-sizes="[5, 10, 15, 20]" :page-size="page.pagesize"
          layout="total, sizes, prev, pager, next" :total=examList.length style="float: right; margin: 15px;" />
      </div>
    </el-card>
    <!-- 添加考试 -->
    <el-dialog v-model="showAddExamDialog" title="添加考试" width="60%">
      <el-form :model="newExamForm" :rules="examFormRules" ref="examFormRef" label-width="100px">
        <el-form-item label="考试名称" prop="name">
          <el-input v-model="newExamForm.name" placeholder="请输入考试名称" />
        </el-form-item>
        <el-form-item label="课程名称" prop="courseId">
          <el-select v-model="newExamForm.courseId" placeholder="请选择课程">
            <el-option v-for="item in courseOptions" :key="item.value" :value="item.value"
              :label="item.label"></el-option>
          </el-select>

        </el-form-item>
        <el-form-item label="试卷名称" prop="paperId">
          <el-select v-model="newExamForm.paperId" placeholder="请选择试卷" style="width: 100%;;">
            <el-option v-for="item in paperOptions" :key="item.value" :value="item.value"
              :label="item.label"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="允许重考" prop="retakeAllow">
          <el-switch v-model="newExamForm.retakeAllow" active-text="是" inactive-text="否" />
        </el-form-item>
        <el-form-item label="重考次数" v-if="newExamForm.retakeAllow">
          <el-input v-model="newExamForm.retakeLimit" placeholder="请输入重考次数限制"></el-input>
        </el-form-item>
        <el-form-item label="考试时长" prop="duration">
          <el-input-number v-model="newExamForm.duration" :min="30" :max="300" />
          <span style="margin-left: 10px">分钟</span>
        </el-form-item>
        <el-form-item label="及格分数" prop="passScore">
          <el-input-number v-model="newExamForm.passScore" :min="0" :max="100" />
          <span style="margin-left: 10px">分</span>
        </el-form-item>
        <el-row>
          <el-col :span="8">
            <el-form-item label="题目乱序" prop="questionDisorder">
              <el-switch v-model="newExamForm.questionDisorder" active-text="是" inactive-text="否" />
            </el-form-item>
          </el-col>
          <el-col :span="8">
            <el-form-item label="选项乱序" prop="optionDisorder">
              <el-switch v-model="newExamForm.optionDisorder" active-text="是" inactive-text="否" />
            </el-form-item>
          </el-col>
        </el-row>
        
      </el-form>
      <template #footer>
        <el-button @click="showAddExamDialog = false">取消</el-button>
        <el-button type="primary" @click="submitAddExam">确定</el-button>
      </template>
    </el-dialog>


    <!-- 考生详情 -->
    <el-drawer v-model="ShowStusView" size="70%" direction="rtl" :before-close="CloseStusView">
      <template #header>
        <h2 style="font-weight: bold; text-align: left;">考生信息</h2>
      </template>
      <el-col :span="24">
        <div style="height: 30px;"></div>
      </el-col>
      <el-table :data="filteredStudents" style="width: 100%" border>
        <el-table-column type="index"></el-table-column>
        <el-table-column prop="userName" label="姓名"></el-table-column>
        <el-table-column prop="department" label="部门"></el-table-column>
        <el-table-column prop="userNumber" label="账号"></el-table-column>
        <!-- <el-table-column prop="examDuration" label="考试时长(分钟)"></el-table-column> -->
        <el-table-column prop="examCount" label="考试次数"></el-table-column>
        <el-table-column prop="highestScore" label="最高得分"></el-table-column>
        <!-- <el-table-column label="操作" width="180" fixed="right">
          <template #default="scope">
            <el-button size="small" type="primary" @click="GradeStu(scope.row)">批改</el-button>
            <el-button size="small" type="danger" @click="Stu_Delete(scope.row)">删除</el-button>
          </template>
        </el-table-column> -->
      </el-table>

      <div class="pagination-container">
        <el-pagination @current-change="StuView_pageschange" :current-page="studentCurrentPage"
          :page-size="studentPageSize" layout="prev, pager, next" :total="studentTotal">
        </el-pagination>
      </div>

    </el-drawer>
    <!-- 编辑考试 -->
    <el-dialog v-model="showExamEditDrawer" title="编辑考试" width="60%">
      <el-form :model="currentExam" :rules="examFormRules" ref="examFormRef" label-width="100px">
        <el-form-item label="考试名称" prop="name">
          <el-input v-model="currentExam.name" placeholder="请输入考试名称" />
        </el-form-item>
        <el-form-item label="课程名称" prop="courseName">
          <el-select v-model="currentExam.courseId" placeholder="请选择课程">
            <el-option v-for="item in courseOptions" :key="item.value" :value="item.value"
              :label="item.label"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="试卷名称" prop="paperId">
          <el-select v-model="currentExam.paperId" placeholder="请选择试卷" style="width: 100%;;">
            <el-option v-for="item in paperOptions" :key="item.value" :value="item.value"
              :label="item.label"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="允许重考" prop="retakeAllow">
          <el-switch v-model="currentExam.retakeAllow" active-text="是" inactive-text="否" />
        </el-form-item>
        <el-form-item label="重考次数" v-if="currentExam.retakeAllow">
          <el-input v-model="currentExam.retakeLimit" placeholder="请输入重考次数限制"></el-input>
        </el-form-item>
        <el-form-item label="考试时长" prop="duration">
          <el-input-number v-model="currentExam.duration" :min="30" :max="300" />
          <span style="margin-left: 10px">分钟</span>
        </el-form-item>
        <el-form-item label="及格分数" prop="passScore">
          <el-input-number v-model="currentExam.passScore" :min="0" :max="100" />
          <span style="margin-left: 10px">分</span>
        </el-form-item>
        <el-row>
          <el-col :span="8">
            <el-form-item label="题目乱序" prop="questionDisorder">
              <el-switch v-model="currentExam.questionDisorder" active-text="是" inactive-text="否" />
            </el-form-item>    
          </el-col>
          <el-col :span="8">
            <el-form-item label="选项乱序" prop="optionDisorder">
              <el-switch v-model="currentExam.optionDisorder" active-text="是" inactive-text="否" />
            </el-form-item>    
          </el-col>
        </el-row>
      </el-form>
      <template #footer>
        <el-button @click="showExamEditDrawer = false">取消</el-button>
        <el-button type="primary" @click="submitEditExam">确定</el-button>
      </template>
    </el-dialog>

  </div>
</template>

<script>
import { ref } from 'vue';
import { deleteExam, getCourseList, getExamList, getPaperInfo, getPaperList, getUserOfExam, updateExam } from '../../api';
import * as XLSX from 'xlsx';

export default {
  data() {
    return {
      ShowStusView: false,
      showExamEditDrawer: false,
      showAddExamDialog: false,
      currentExam: null,
      newExamForm: {
        name: '',
        courseId: '',
        paperId: '',
        retakeAllow: false,
        retakeLimit: 0,
        duration: 120,
        passScore: 60,
        questionDisorder: 0,
        optionDisorder:0
      },
      queryInfo: {
        courseId: '',
        paperId: '',
        examName:''
      },
      page: {
        pagenum: 1, //当前页
        pagesize: 10,
      },
      examFormRules: {
        name: [
          { required: true, message: '请输入考试名称', trigger: 'blur' }
        ],
        courseId: [
          { required: true, message: '请输入课程ID', trigger: 'blur' }
        ],
        paperId: [
          { required: true, message: '请输入试卷ID', trigger: 'blur' }
        ],
        duration: [
          { required: true, message: '请输入考试时长', trigger: 'blur' },
          { type: 'number', message: '时长必须为数字', trigger: 'blur' }
        ],
        passScore: [
          { required: true, message: '请输入及格分数', trigger: 'blur' },
          { type: 'number', message: '分数必须为数字', trigger: 'blur' }
        ],
      },
      studentSearchQuery: '',

      studentList: [],
      studentPageSize: 5,
      studentCurrentPage: 1,
      studentTotal: 2, // 初始化考生总数
      examList: [],
      paperOptions: [],
      courseOptions:[],
      searchQuery: '',
      currentPage: 1,
      total: 0
    }
  },
  computed: {
    paginatedExams() {
      const filteredExams = this.examList.filter(exam => {
        return (
          (this.queryInfo.courseId === '' || exam.courseId === this.queryInfo.courseId) &&
          (this.queryInfo.examName === '' || exam.name.includes(this.queryInfo.examName)) &&
          (this.queryInfo.paperId === '' || exam.paperId === this.queryInfo.paperId) 
        );
      });
      const start = (this.page.pagenum - 1) * this.page.pagesize;
      const end = start + this.page.pagesize;
      return filteredExams.slice(start, end);
    },
    filteredStudents() {
      if (!this.studentSearchQuery.trim()) {
        return this.studentList;
      }
      return this.studentList.filter(student =>
        student.userName.includes(this.studentSearchQuery)
      );
    }
  },
  created() {
    this.total = this.examList.length;
    this.loadPaperOptions();
    // this.loadCourseOptions();
  },
  mounted() {
    this.getExamData();
    this.loadPaperOptions();
    this.loadCourseOptions();
  },
  methods: {
    ExamPageschange(val) {
      this.currentPage = val;
    },
    handleCurrentChange(val) {
      this.page.pagenum = val;
    },
    handleSizeChange(val) {
      this.page.pagesize = val;
      this.page.pagenum = 1; // Reset to the first page on page size change
    },

    //获取考试信息列表
    getExamData() {
      getExamList().then(res => {
        const data = res.data.data; // 假设返回的数据结构是 { data: { list: [...] } }
        // console.log(data);
        this.examList = data.map(exam => ({
          id: exam.examId, // 考试ID
          name: exam.examName, // 考试名称
          courseId:exam.courseId,
          courseName: exam.courseName, // 课程名称
          paperId: exam.paperId, // 试卷ID
          paperName:exam.paperName,
          retakeAllow: exam.retakeAllowed > 0, // 允许重考（假设>0表示允许，其他值表示不允许）
          retakeLimit: exam.retakeAllowed,
          questionDisorder: exam.questionDisorder===1,
          optionDisorder:exam.optionDisorder===1,
          createTime: exam.timeCreate, // 创建时间（这里需要根据实际返回的时间格式调整）
          updateTime: exam.timeModify, // 更新时间（这里需要根据实际返回的时间格式调整）
          duration: exam.duration, // 考试时长
          passScore: exam.passMark, // 及格分数
          courseCover: exam.courseCover, // 课程封面
          courseDescription: exam.courseDescription, // 课程描述
          courseType: exam.courseType, // 课程类型
          courseTeacher: exam.courseTeacher // 课程教师
        }));
        // console.log(this.examList);
        this.examList.sort((a, b) => a.id - b.id);
        this.total = this.examList.length; // 更新总记录数
      }).catch(err => {
        console.error('获取考试数据失败:', err);
        this.$message.error('获取考试数据失败，请稍后重试');
      });
    },

    loadPaperOptions() {
      getPaperList().then((res) => {
        const data = res.data.data;
        this.paperOptions = data.map(item => ({
          value: item.paperId,
          label:item.paperName
        }));
        // console.log(this.paperOptions);
      }).catch(err => {
        console.error('获取试卷ID列表失败:', err);
        this.$message.error('获取试卷ID列表失败，请稍后重试');
      })
    },
    loadCourseOptions() {
      getCourseList().then((res) => {
        const data = res.data.data;
        this.courseOptions = data.map(item => ({
          value: item.courseId,
          label: item.courseName
        }));
        // console.log(this.paperOptions);
      }).catch(err => {
        console.error('获取课程ID列表失败:', err);
        this.$message.error('获取课程ID列表失败，请稍后重试');
      })
    },

    resetQuery() {
      this.queryInfo = {
        courseId: '',
        paperId: '',
        examName:''
      }
      this.getExamData();
    },

    ViewStus(row) {
      this.ShowStusView = true;
      this.currentExam = row;
      // console.log(this.currentExam.id);
      getUserOfExam(this.currentExam.id).then(res => {
        this.studentList = res.data;
      })
      this.studentTotal = this.studentList.length; // 更新考生总数
    },
    CloseStusView() {
      this.ShowStusView = false;
    },
    GradeStu(row) {
      console.log('批改考生', row);
      // 调用批改接口
    },
    Stu_Delete(row) {
      console.log('删除考生', row);
      // 调用删除考生接口
      //确认删除
      this.$confirm('此操作将永久删除该考生, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      })
        .then(() => {
          // 调用删除接口
          this.$message({
            type: 'success',
            message: '考生已删除'
          });
        })
        .catch(() => {
          this.$message({
            type: 'info',
            message: '已取消删除'
          })
        })
    },

    StuView_pageschange(val) {
      this.studentCurrentPage = val;
      // 这里可以添加获取分页考生数据的逻辑
      console.log('考生分页变化', val);
    },


    PublishExam(row) {
      //确认发布
      this.$confirm('此操作将发布该考试, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      })
        .then(() => {
          // 调用发布接口
          this.$message({
            type: 'success',
            message: '考试已发布'
          });
        })
        .catch(() => {
          this.$message({
            type: 'info',
            message: '已取消发布'
          })
        })
      console.log('发布考试', row)
      // 调用发布接口
    },
    EditExam(row) {
      this.currentExam = row;
      console.log(this.currentExam);
      this.showExamEditDrawer = true;
      // 这里可以添加获取试卷详细信息的API调用
    },

    submitEditExam() {
      this.$refs.examFormRef.validate((valid) => {
        const Exam = {
          examId: this.currentExam.id,
          examName: this.currentExam.name,
          courseId: this.currentExam.courseId,
          paperId: this.currentExam.paperId,
          retakeAllowed: this.currentExam.retakeLimit,
          duration: this.currentExam.duration,
          passMark: this.currentExam.passScore,
          questionDisorder: this.currentExam.questionDisorder ? 1 : 0,
          optionDisorder:this.currentExam.optionDisorder?1:0
        };
        // console.log(Exam);
        if (valid) {
          updateExam(Exam).then(res => {
            this.getExamData();
            this.$message.success('考试更新成功');
            this.showExamEditDrawer = false;
          })
        } else {
          return false;
        }
      });
    },
    DeleteExam(id) {
      this.$confirm('此操作将永久删除该考试, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        deleteExam(id).then(() => {
          this.getExamData();
        })
      }).catch(() => {
        this.$message({
          type: 'info',
          message: '已取消删除'
        })
      })
      console.log('删除考试序号:', id)
      // 调用删除接口
    },
    
    async getMaxScore (examId, userId){
      try {
        const response = await axios.get(`http://localhost:8081/examinfo/maxScore?examId=${examId}&userId=${userId}`);
        return response.data; 
      } catch (error) {
        console.error(`Error fetching max score for examId ${examId}:`, error);
      }
    },
    // showAddExamDialog() {
    //   this.showAddExamDialog = true;
    //   this.$nextTick(() => {
    //     this.$refs.examFormRef?.resetFields();
    //   });
    // },

    submitAddExam() {
      this.$refs.examFormRef.validate((valid) => {
        if (valid) {
          const newExam = {
            examName: this.newExamForm.name,
            courseId: this.newExamForm.courseId,
            paperId: this.newExamForm.paperId,
            retakeAllowed: this.newExamForm.retakeLimit,
            duration: this.newExamForm.duration,
            passMark: this.newExamForm.passScore,
            questionDisorder: this.newExamForm.questionDisorder?1:0,
            optionDisorder:this.newExamForm.optionDisorder?1:0
          };
          console.log(newExam);
          getPaperInfo(newExam.paperId).then(res => {
            const data = res.data.data;
            const ts = data.paperInfo.totalScore;
            if (newExam.passMark > ts) {
              this.$message.error('及格分数不能大于试卷总分');
            } else {
              updateExam(newExam).then(() => {
                this.getExamData();
                // console.log(this.examList);
                this.showAddExamDialog = false;
                this.$message.success('考试添加成功');  
              }).catch((err) => {
                console.error('添加考试失败', err);
                this.$message.error('添加考试失败，请稍后重试');
              })    
            }
          })
        } else {
          return false;
        }
      });
    },

    downloadExams() {
      console.log('下载');
      const wb = XLSX.utils.book_new();
      const wsData = this.examList.map(exam => ({
        '考试ID': exam.id,
        '考试名称': exam.name,
        '课程名称': exam.courseName,
        '试卷名称': exam.paperName,
        '允许重考': exam.retakeAllow ? '是' : '否',
        '考试时长(分钟)': exam.duration,
        '及格分数': exam.passScore,
        '创建时间': exam.createTime,
        '更新时间': exam.updateTime
      }));

      const ws = XLSX.utils.json_to_sheet(wsData);
      XLSX.utils.book_append_sheet(wb, ws, '考试列表');

      XLSX.writeFile(wb, '考试列表.xlsx');
    },

    SearchExams() {
      if (!this.searchQuery.trim()) {
        this.getExamData();
        return;
      }
      this.searchExams(this.searchQuery);
    },
    searchExams(query) {
      // 本地搜索
      const filtered = this.examList.filter(exam =>
        exam.name.includes(query) || exam.courseId.includes(query) || exam.paperId.includes(query)
      );
      this.total = filtered.length;
      this.currentPage = 1;
      this.examList = filtered;
      console.log('搜索考试', query)
    },
    

  },
  watch: {
    searchQuery(newVal) {
      if (newVal.trim() === '')
        this.getExamData();
      //实时搜索
      //  else {
      //     this.searchExams(newVal);
      // }
    },
  }
} 
</script>

<style scoped>
.exam-list {
  padding: 15px;
}

.pagination-container {
  float: right;
  /* 确保分页器在右侧 */
  ;
  margin: 15px;
  bottom: 15px;
  /* 距离底部的距离 */
}

/* 过渡动画 */
.fade-enter-active,
.fade-leave-active {
  transition: all 0.5s ease;
}

.fade-enter-from {
  opacity: 0;
  transform: translateX(100%);
}

.fade-leave-to {
  opacity: 0;
  transform: translateX(100%);
}

/* 在组件样式或全局样式中添加 */
.el-select-dropdown__item {
  display: block !important;
  width: 100% !important;
}
</style>