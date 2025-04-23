<template>
  <div style="margin: 15px;">
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: '/HomePage' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>课程管理</el-breadcrumb-item>
      <el-breadcrumb-item>课程列表</el-breadcrumb-item>
    </el-breadcrumb>
    <el-card>
      <div class="query-section">
        <div class="query-row">
          <span class="query-label">课程名称</span>
          <el-input placeholder="请输入课程名称" v-model="queryInfo.courseName" style="width:150px"></el-input>
          <span class="query-label">课程分类</span>
          <el-select v-model="queryInfo.courseType" placeholder="请选择课程分类" style="width:150px">
            <el-option label="公选课" value="0"></el-option>
            <el-option label="必选课" value="1"></el-option>
          </el-select>
          <span class="query-label">讲师名称</span>
          <el-input placeholder="请输入讲师" v-model="queryInfo.teacher" style="width:100px"></el-input>
          <el-button type="primary" @click="resetQuery">重置</el-button>
        </div>
      </div>
      <div class="button-section">
        <div class="left-buttons">
          <el-button type="primary" @click="goToAddCourse">添加课程</el-button>
        </div>
        <el-button @click="downloadCourses" style="float: right;">下载</el-button>
      </div>
      <hr class="divider">
      <el-table v-if="!loading && goodList.length > 0" :data="goodList">
        <el-table-column type="index"></el-table-column>
        <el-table-column prop="course_cover" label="课程图片">
          <template #default="scope">
            <img :src="scope.row.course_cover" alt="课程图片" style="width: 100px; height: 70px;">
          </template>
        </el-table-column>
        <el-table-column prop="course_name" label="课程名称"></el-table-column>
        <el-table-column prop="course_type" label="课程分类">
          <template #default="scope">
            <span>{{ scope.row.course_type === 0? '公选课' : '必选课' }}</span>
          </template>
        </el-table-column>
        <el-table-column prop="course_teacher" label="讲师"></el-table-column>
        <el-table-column prop="course_rating" label="课程评分">
          <template #default="scope">
            <el-rate v-model="scope.row.course_rating" :colors="['#f5a623']" :disabled="true"></el-rate>
          </template>
        </el-table-column>
        <el-table-column prop="study_count" label="学习人数" class="study-count-column">
          <template #default="scope">
            <span class="study-count-data">{{ scope.row.study_count }}</span>
          </template>
        </el-table-column>
        <el-table-column label="操作">
          <template #default="scope">

          <div class="operation-buttons">
            <el-button type="primary" @click="goToEditCourse(scope.row.course_id)">修改</el-button>
            <el-button type="danger" @click="confirmDelete(scope.row.course_id)">删除</el-button>
          </div>
          </template>
        </el-table-column>
      </el-table>
      <el-alert v-else-if="!loading" title="没有数据" type="info"></el-alert>
      <el-spinner v-if="loading" />

      <!-- 分页 -->
      <el-pagination
          @size-change="handleSizechange"
          @current-change="handleCurrentChange"
          :current-page="queryInfo.pagenum"
          :page-sizes="[5,10,15,20]"
          :page-size="queryInfo.pagesize"
          layout="total,sizes,prev,pager,next,jumper"
          :total="totalCount" style="float:right;margin: 10px;"> <!-- 使用 totalCount -->
      </el-pagination>
    </el-card>
  </div>
</template>

<script>
import { ref, onMounted, computed } from 'vue';
import { ElMessage, ElMessageBox } from 'element-plus';
import axios from 'axios';
import * as XLSX from 'xlsx';
import { useRouter } from "vue-router";

export default {
  setup() {
    const queryInfo = ref({
      courseType: '',
      courseName: '',
      teacher: '',
      pagenum: 1,
      pagesize: 10
    });
    const totalCount = ref(0);
    const courseListData = ref([]);
    const batchImportDialogVisible = ref(false);
    const loading = ref(false);
    const router = useRouter();

    const goodList = computed(() => {
      const filteredCourses = courseListData.value.filter(course => {
        return (
            (queryInfo.value.courseName === '' || course.course_name.includes(queryInfo.value.courseName)) &&
            (queryInfo.value.courseType === '' || course.course_type == queryInfo.value.courseType) &&
            (queryInfo.value.teacher === '' || course.course_teacher.includes(queryInfo.value.teacher))
        );
      });

      const start = (queryInfo.value.pagenum - 1) * queryInfo.value.pagesize;
      const end = start + queryInfo.value.pagesize;
      return filteredCourses.slice(start, end);
    });

    const total = computed(() => {
      return courseListData.value.filter(course => {
        return (
            (queryInfo.value.courseName === '' || course.course_name.includes(queryInfo.value.courseName)) &&
            (queryInfo.value.courseType === '' || course.course_type == queryInfo.value.courseType) &&
            (queryInfo.value.teacher === '' || course.course_teacher.includes(queryInfo.value.teacher))
        );
      }).length;
    });

    const queryCourses = () => {
      loading.value = true;
      const params = {
        courseType: queryInfo.value.courseType,
        courseName: queryInfo.value.courseName,
        teacher: queryInfo.value.teacher,
      };

      axios.get('http://localhost:8081/course/showAll', { params })
          .then(response => {
            if (response.data.code === 0) {
              const courses = response.data.data;

              const coursePromises = courses.map(course => {
                const ratingPromise = axios.get(`http://localhost:8081/assess/average/${course.courseId}`)
                    .then(scoreResponse => {
                      course.course_rating = scoreResponse.data;
                    })
                    .catch(() => {
                      course.course_rating = 0;
                    });

                const countPromise = axios.get(`http://localhost:8081/ucourse/count/${course.courseId}`)
                    .then(countResponse => {
                      course.study_count = countResponse.data;
                    })
                    .catch(() => {
                      course.study_count = 0;
                    });

                return Promise.all([ratingPromise, countPromise]).then(() => course);
              });

              Promise.all(coursePromises).then(updatedCourses => {
                courseListData.value = updatedCourses.map(course => ({
                  course_id: course.courseId,
                  course_name: course.courseName,
                  course_cover: course.courseCover || 'https://default-image-url.com/default.jpg',
                  course_type: course.courseType,
                  course_teacher: course.courseTeacher,
                  course_rating: course.course_rating || 0,
                  study_count: course.study_count || 0
                }));
                totalCount.value = updatedCourses.length;
              });
            } else {
              ElMessage.error('获取课程数据失败: ' + response.data.message);
            }
          })
          .catch(error => {
            console.error(error);
            ElMessage.error('获取课程数据失败');
          })
          .finally(() => {
            loading.value = false;
          });
    };

    const resetQuery = () => {
      queryInfo.value = {
        courseType: '',
        courseName: '',
        teacher: '',
        pagenum: 1,
        pagesize: 10
      };
      queryCourses();
    };

    const handleSizechange = (val) => {
      queryInfo.value.pagesize = val;
      queryCourses();
    };

    const handleCurrentChange = (val) => {
      queryInfo.value.pagenum = val;
      queryCourses();
    };

    const goToAddCourse = () => {
      router.push({ path: 'bg_c_add' });
    };

    const downloadCourses = () => {
      const wb = XLSX.utils.book_new();
      const wsData = courseListData.value.map(course => ({
        '课程ID': course.course_id,
        '课程名称': course.course_name,
        '课程图片': course.course_cover,
        '课程分类': course.course_type === 0? '公选课' : '必选课',
        '讲师': course.course_teacher,
        '课程评分': course.course_rating,
        '学习人数': course.study_count
      }));

      const ws = XLSX.utils.json_to_sheet(wsData);
      XLSX.utils.book_append_sheet(wb, ws, '课程列表');

      XLSX.writeFile(wb, '课程列表.xlsx');
    };

    const goToEditCourse = (course_id) => {
      console.log(course_id);
      router.push({ path: `bg_c_edit/${course_id}` });
    };

    const confirmDelete = (courseId) => {
      ElMessageBox.confirm('确定要删除该课程吗？', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        // 发送 DELETE 请求到后端
        axios.delete(`http://localhost:8081/course/delete?courseId=${courseId}`)
            .then(response => {
              if (response.data.code === 0) {
                const index = courseListData.value.findIndex(item => item.course_id === courseId);
                if (index !== -1) {
                  courseListData.value.splice(index, 1);
                }
                ElMessage.success('删除成功');
              } else {
                ElMessage.error('删除失败: ' + response.data.message);
              }
            })
            .catch(error => {
              console.error(error);
              ElMessage.error('删除失败');
            });
      }).catch(() => {
        ElMessage.info('已取消删除');
      });
    };

    onMounted(() => {
      queryCourses();
    });

    return {
      queryInfo,
      totalCount,
      courseListData,
      batchImportDialogVisible,
      loading,
      goodList,
      queryCourses,
      resetQuery,
      handleSizechange,
      handleCurrentChange,
      goToAddCourse,
      downloadCourses,
      goToEditCourse,
      confirmDelete
    };
  }
};
</script>

<style>
.el-input {
  width: 200px;
}

.query-section {
  margin-bottom: 10px;
}

.query-title {
  margin-bottom: 5px;
}

.query-row {
  display: flex;
  align-items: center;
  gap: 30px;
}

.button-row {
  display: flex;
  align-items: center;
  margin-top: 5px;
}

.button-section {
  display: flex;
  justify-content: space-between;
  margin-bottom: 10px;
}

.left-buttons {
  display: flex;
  align-items: center;
}

.divider {
  margin: 10px 0;
}

.operation-buttons {
  display: flex;
  flex-direction: row;
  align-items: center;
}

/* 尝试使用 margin-left 来移动数据 */
.study-count-data {
  margin-left: 20px;
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
</style>