<template>
  <div style="padding: 15px;">
    <el-breadcrumb>
      <el-breadcrumb-item :to="{ path: '/bg_home' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>题库管理</el-breadcrumb-item>
      <el-breadcrumb-item>题库列表</el-breadcrumb-item>
    </el-breadcrumb>
    <el-card>
      <el-row :gutter="20">
        <el-col>
          <span style="white-space: nowrap;margin: 10px;">题库名称</span>
          <el-input placeholder="请输入题库名称" v-model="queryInfo.title" style="width: 200px"></el-input>
          <span style="white-space: nowrap;margin: 10px;">课程分类</span>
          <el-select v-model="queryInfo.courseId" placeholder="请选择课程" @change="loadExamsByCourse" style="width: 200px;">
            <el-option v-for="item in courseOptions" :key="item.value" :value="item.value"
              :label="item.label"></el-option>
          </el-select>
          <el-button type="primary" @click="resetQuery" style="margin-left: 10px;">重置</el-button>
          <el-button type="primary" @click="banksAddVisible = true">添加题库</el-button>
        </el-col>
      </el-row>
      <el-row :gutter="20">
        <el-col :span="24">
          <div style="height: 20px;"></div>
        </el-col>
      </el-row>
      <el-table :data="bankList" border stripe>
        <el-table-column type="selection"></el-table-column>
        <el-table-column prop="bankName" label="题库名称"></el-table-column>
        <el-table-column label="题库所属课程" width="200px">
          <template #default="scope">
            {{ getCourseName(scope.row.courseId) }}
          </template>
        </el-table-column>
        <el-table-column prop="itemCount" label="试题数" width="80px"></el-table-column>
        <el-table-column label="更新时间" prop="timeModify" width="162px"></el-table-column>
        <el-table-column label="操作" width="300px">
          <template #default="scope">
            <el-button type="text" @click="associateQuestions(scope.row)">关联题目</el-button>
            <el-button type="primary" @click="edit(scope.row)" style="margin-right: 5px;">编辑</el-button>
            <el-button type="danger" @click="deleteBanks(scope.row.bankId)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
      <!-- 分页 -->
      <el-pagination @size-change="handleSizeChange" @current-change="handleCurrentChange"
        :current-page="queryInfo.pagenum" :page-sizes="[3, 5, 10, 15]" :page-size="queryInfo.pagesize"
        layout="total,sizes,prev,pager,next,jumper" :total="total" background
        style="margin: 10px;float:right"></el-pagination>

      <!-- 添加题库 -->
      <el-dialog v-model="banksAddVisible" title="添加题库" width="50%">
        <el-form :model="addForm" label-width="80px">
          <el-form-item label="题库名称">
            <el-input v-model="addForm.bankName" placeholder="请输入题库名称" width="100%" />
          </el-form-item>
          <el-form-item label="所属课程">
            <el-select v-model="addForm.courseId" placeholder="请选择课程名称">
              <el-option v-for="item in courseOptions" :key="item.value" :value="item.value"
                :label="item.label"></el-option>
            </el-select>
          </el-form-item>
        </el-form>
        <template #footer>
          <el-button @click="banksAddVisible = false">取消</el-button>
          <el-button type="primary" @click="addBanks">确认</el-button>
        </template>
      </el-dialog>

      <!-- 编辑题库 -->
      <el-dialog v-model="bankEditVisible" title="编辑题库" width="50%">
        <el-form>
          <el-form-item label="题库名称">
            <el-input v-model="currentBank.bankName" />
          </el-form-item>
          <el-form-item label="所属课程">
            <el-select v-model="currentBank.courseId" placeholder="请选择课程名称">
              <el-option v-for="item in courseOptions" :key="item.value" :value="item.value"
                :label="item.label"></el-option>
            </el-select>
          </el-form-item>
        </el-form>
        <template #footer>
          <el-button @click="bankEditVisible = false">取消</el-button>
          <el-button type="primary" @click="editBanks">确认</el-button>
        </template>
      </el-dialog>
    </el-card>
  </div>
</template>

<script>
import { ref, reactive, onMounted, computed, getCurrentInstance } from 'vue';
import bg_quedetail from './bg_quedetail.vue';
import { addBank, deleteBank, findCourse, getBankList, getCourseList, updateBank } from '../../api';
import { ElMessage, ElMessageBox } from 'element-plus';
import { useRouter } from 'vue-router';

export default {
  components: { bg_quedetail },
  setup() {
    const router = useRouter();
    const allData = ref([]);
    const courseMap = ref({});
    const courseOptions = ref([]);
    const { proxy } = getCurrentInstance();
    const queryInfo = ref({
      query: '',
      pagenum: 1,
      pagesize: 10,
      title: '',
      courseId:'',
      userName: '',
      status: '',
      level: ''
    });
    const total = ref(0);
    const addForm = reactive({
      bankName: '',
      courseId: '',
      courseName:''
    });
    const currentBank = ref({
      bankName: '',
      courseId: ''
    });
    const banksAddVisible = ref(false);
    const bankEditVisible = ref(false);

    const handleQuery = () => {
      const { title, userName } = queryInfo.value;
      const filteredData = allData.value.filter((item) => {
        const matchesTitle = title === '' || item.goods_name.includes(title);
        const matchesUserName = userName === '' || item.creator.includes(userName);
        return matchesTitle && matchesUserName;
      });
      allData.value = filteredData;
      total.value = filteredData.length;
      saveGoodsData();
    };

    const handleSizeChange = (val) => {
      queryInfo.value.pagesize = val;
    };

    const handleCurrentChange = (val) => {
      queryInfo.value.pagenum = val;
    };

    const addBanks = () => {
      const newBank = {
        bankName: addForm.bankName,
        courseId: addForm.courseId
      };
      addBank(newBank).then(res => {
        if (res.data.code === 0) {
          ElMessage.success('添加成功');
          loadBankData();
        } else {
          ElMessage.error('添加失败');
        }
      })
      banksAddVisible.value = false;
    };

    const getCourseName = (id) => {
      return courseMap.value[id] || '未知课程';
    }

    const associateQuestions = (bank) => {
      proxy.$store.commit("setBankName", bank.bankName);
      router.push(`/bg_home/quebank/${bank.bankId}`);
      // console.log('关联题目', id);
    };

    const edit = (row) => {
      bankEditVisible.value = true;
      currentBank.value = row;
    };

    const editBanks = () => {
      console.log(currentBank.value);
      const bank = {
        bankId:currentBank.value.bankId,
        bankName: currentBank.value.bankName,
        courseId: currentBank.value.courseId
      }
      updateBank(bank).then(res => {
        if (res.data.code === 0) {
          ElMessage.success('更新成功');
          bankEditVisible.value = false;
          loadBankData();
        } else {
          ElMessage.error('更新失败');
        }
      }).catch(err => {
        console.error(err);
      })
    };

    const deleteBanks = (id) => {
      ElMessageBox.confirm('确定要删除该题库吗？', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(async () => {
        const res = await deleteBank(id); 
        if (res.data.code === 0) {
          ElMessage.success('删除成功');
          loadBankData();    
        } else {
          ElMessage.error('删除失败');
        }
      });
        
    };

    const loadBankData = () => {
      getBankList().then(res => {
        const data = res.data;
        allData.value = data;
        total.value = allData.value.length;
      }).catch(err => {
        console.error('获取试卷数据失败:', err);
      });
    };

    const loadCourseOptions = () => {
      getCourseList().then((res) => {
        const data = res.data.data;
        res.data.data.forEach(course => {
          courseMap.value[course.courseId] = course.courseName;
        });
        courseOptions.value = data.map(item => ({
          value: item.courseId,
          label: item.courseName
        }));
        // console.log(courseOptions.value);
      }).catch(err => {
        console.error('获取课程ID列表失败:', err);
        this.$message.error('获取课程ID列表失败，请稍后重试');
      })
    };

    const saveGoodsData = () => {
      localStorage.setItem('goodList', JSON.stringify(allData.value));
    };

    const resetQuery = () => {
      console.log('重置');
      queryInfo.value = {
        query: '',
        pagenum: 1,
        pagesize: 10,
        courseId: '',
        title: '',
        userName: '',
        status: '',
        level: ''
      }
      loadBankData();
    };

    onMounted(() => {
      loadBankData();
      loadCourseOptions();
    });

    const bankList = computed(() => {
      const filteredData = allData.value.filter(bank => {
        return (
          (!queryInfo.value.title || bank.bankName.includes(queryInfo.value.title)) &&
          (!queryInfo.value.courseId || bank.courseId === queryInfo.value.courseId)
        );
      });
      const start = (queryInfo.value.pagenum - 1) * queryInfo.value.pagesize;
      const end = start + queryInfo.value.pagesize;
      return filteredData.slice(start, end);
    });

    return {
      allData,
      queryInfo,
      total,
      addForm,
      currentBank,
      banksAddVisible,
      bankEditVisible,
      handleQuery,
      handleSizeChange,
      handleCurrentChange,
      addBanks,
      associateQuestions,
      edit,
      editBanks,
      deleteBanks,
      bankList,
      getCourseName,
      courseOptions,
      resetQuery,
    };
  }
};
</script>