<template>
  <div>

    <el-row :gutter="20">
      <el-col :span="7">
        <el-card shadow="card" class="mgb20" style="height: 550px;">
          <div class="card-header">
            <p class="card-header-title">新的课程评论</p>
            <p class="card-header-desc">最新的课程评价信息</p>
          </div>
          <div class="comment-container" style="overflow-y: scroll; height: 450px;">
            <el-timeline>
              <el-timeline-item v-for="(comment, index) in newCourseComments" :key="index" :color="comment.color">
                <div class="timeline-item">
                  <div>
                    <p>{{ comment.courseName }}有了新的评价</p>
                    <p class="f6 timeline-desc">{{ comment.content }}</p>
                  </div>
                  <div class="timeline-time">{{ comment.timeCreate }}</div>
                </div>
              </el-timeline-item>
            </el-timeline>
          </div>
        </el-card>

      </el-col>
      <el-col :span="10">
        <el-card shadow="hover" style="height: 550px;">
          <div class="card-header">
            <p class="card-header-title">问题解决情况统计</p>
            <p class="card-header-desc">最近一段时间内问题解决的比例情况</p>
          </div>
          <v-chart class="chart" :option="questionSolvePieChartOption" />
        </el-card>
      </el-col>
      <el-col :span="7">
        <el-card shadow="hover" style="height: 550px;">
          <div class="card-header">
            <p class="card-header-title">最受欢迎课程排行榜</p>
            <p class="card-header-desc">按选课人数统计的热门课程Top5</p>
          </div>
          <div>
            <div class="rank-item" v-for="(rank, index) in popularCoursesRanks" :key="index">
              <div class="rank-item-avatar">{{ index + 1 }}</div>
              <div class="rank-item-content">
                <div class="rank-item-top">
                  <div class="rank-item-title">{{ rank.courseName }}</div>
                  <div class="rank-item-desc">选课人数：{{ rank.studentCount }}</div>
                </div>
                <el-progress :show-text="false" :percentage="rank.percentage" :color="rank.color" :stroke-width="10"
                  striped></el-progress>
              </div>
            </div>
          </div>
        </el-card>
      </el-col>
    </el-row>
    <el-row type="flex" :gutter="20">
      <el-col :span="18">
        <el-card shadow="hover">
          <div class="card-header">
            <p class="card-header-title">课程完成度趋势</p>
            <p class="card-header-desc">最近一段时间学生课程完成度变化情况</p>
          </div>
          <v-chart class="chart" :option="courseCompletionLineChartOption" />
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card shadow="hover" style="height: 560px;">
          <div class="class-header">
            <p class="card-header-title">公选课必修课比例</p>
            <p class="card-header-desc">课程中公选课与必修课的占比情况</p>
          </div>
          <v-chart class="chart" :option="courseTypePieChartOption"></v-chart>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script setup lang="ts">
import { ChatDotRound, Notebook, ShoppingCartFull, Tickets } from '@element-plus/icons-vue';
import countup from '../../components/countUp.vue';
import { use, registerMap } from 'echarts/core';
import { BarChart, LineChart, PieChart, MapChart } from 'echarts/charts';
import {
  GridComponent,
  TooltipComponent,
  LegendComponent,
  TitleComponent,
  VisualMapComponent,
} from 'echarts/components';
import { CanvasRenderer } from 'echarts/renderers';
import VChart from 'vue-echarts';
import { onMounted, watch, reactive, computed } from 'vue';
import axios from 'axios';
import dayjs from 'dayjs';

use([
  CanvasRenderer,
  BarChart,
  GridComponent,
  LineChart,
  PieChart,
  TooltipComponent,
  LegendComponent,
  TitleComponent,
  VisualMapComponent,
  MapChart,
]);

// 模拟从localStorage获取用户名，实际可按需调整
const username: string | null = localStorage.getItem('username');

// 课程完成度数据，改为响应式
const courseCompletionData = reactive([]);

// 课程完成度折线图配置，改为响应式
const courseCompletionLineChartOption = reactive({
  xAxis: {
    type: 'category',
    data: []
  },
  yAxis: {
    type: 'value',
  },
  series: [
    {
      data: [],
      type: 'line',
      smooth: true,
    },
  ],
  tooltip: {
    trigger: 'axis',
  },
  grid: {
    left: '3%',
    right: '4%',
    bottom: '3%',
    containLabel: true,
  },
});

// 公选课必修课比例数据，改为响应式
const courseTypeData = reactive({
  required: 0,
  optional: 0
});

// 公选课必修课比例饼图配置，改为计算属性
const courseTypePieChartOption = computed(() => ({
  // 新增图例配置
  legend: {
    type: 'plain',
    bottom: 10,
    left: 'center',
    data: ['必修课', '公选课']
  },
  series: [
    {
      name: '课程类型比例',
      type: 'pie',
      data: [
        { value: courseTypeData.required, name: '必修课' },
        { value: courseTypeData.optional, name: '公选课' },
      ],
      radius: '50%',
      label: {
        show: true,
        formatter: '{b}: {d}%',
      },
    },
  ],
  tooltip: {
    trigger: 'item',
    formatter: '{a} <br/>{b}: {c} ({d}%)',
  }
}));

// 定义评论数据的类型
interface Comment {
  courseName: string;
  content: string;
  timeCreate: string;
  color: string;
}
// 新的课程评论数据，改为响应式并指定类型
const newCourseComments: Comment[] = reactive([]);

// 问题解决情况统计数据，改为响应式
const questionSolveData = reactive({
  solved: 0,
  unsolved: 0
});

// 问题解决情况统计饼图配置，改为计算属性
const questionSolvePieChartOption = computed(() => ({
  legend: {
    type: 'plain',
    show: true,
    bottom: '0%',
    left: 'center',
    data: ['已解决', '未解决']
  },
  series: [
    {
      name: '问题解决比例',
      type: 'pie',
      data: [
        { value: questionSolveData.solved, name: '已解决' },
        { value: questionSolveData.unsolved, name: '未解决' },
      ],
      radius: '50%',
      label: {
        show: true,
        formatter: '{b}: {d}%',
      },
      center: ['50%', '40%']
    },
  ],
  tooltip: {
    trigger: 'item',
    formatter: '{a} <br/>{b}: {c} ({d}%)',
  }
}));

// 定义排行榜数据类型
interface PopularCourseRank {
  courseName: string;
  studentCount: number;
  percentage: number;
  color: string;
}
// 最受欢迎课程排行榜数据，改为响应式并指定类型
const popularCoursesRanks: PopularCourseRank[] = reactive([]);

const colors = ['#f25e43', '#00bcd4', '#64d572', '#e9a745', '#009688']; // 定义五种颜色

onMounted(async () => {
  try {
    // 获取课程数据
    const courseResponse = await axios.get('http://localhost:8081/course/showAll');
    const courses = courseResponse.data.data;
    // 为参数添加类型定义
    const courseMap = courses.reduce((acc: { [key: number]: string }, course: { courseId: number; courseName: string }) => {
      acc[course.courseId] = course.courseName;
      return acc;
    }, {} as { [key: number]: string });

    // 获取选课数据
    const userCourseResponse = await axios.get('http://localhost:8081/ucourse/all');
    const userCourseData = userCourseResponse.data;
    const courseIdCountMap = {} as { [key: number]: number };
    userCourseData.forEach((item: { courseId: any; }) => {
      const courseId = item.courseId;
      courseIdCountMap[courseId] = (courseIdCountMap[courseId] || 0) + 1;
    });

    // 整理排行榜数据
    const rankList: PopularCourseRank[] = [];
    for (const courseId in courseIdCountMap) {
      const courseName = courseMap[parseInt(courseId)];
      if (courseName) {
        rankList.push({
          courseName,
          studentCount: courseIdCountMap[parseInt(courseId)],
          percentage: 0,
          color: ''
        });
      }
    }
    // 按选课人数排序
    rankList.sort((a, b) => b.studentCount - a.studentCount);
    const top5RankList = rankList.slice(0, 5);

    if (top5RankList.length > 0) {
      const maxStudentCount = top5RankList[0].studentCount;
      top5RankList.forEach((rank, index) => {
        rank.percentage = (rank.studentCount / maxStudentCount) * 100;
        rank.color = colors[index];
      });
    }
    popularCoursesRanks.push(...top5RankList);

    // 处理公选课必修课比例数据
    let requiredCount = 0;
    let optionalCount = 0;
    courses.forEach((course: { courseType: number; }) => {
      if (course.courseType === 1) {
        requiredCount++;
      } else if (course.courseType === 0) {
        optionalCount++;
      }
    });
    courseTypeData.required = requiredCount;
    courseTypeData.optional = optionalCount;

    // 获取评论数据
    const assessResponse = await axios.get('http://localhost:8081/assess/all');
    const assessData = assessResponse.data;
    const commentList: Comment[] = [];
    assessData.forEach((assess: { courseId: string | number; timeCreate: any; assessContent: any; }) => {
      const courseName = courseMap[assess.courseId];
      if (courseName) {
        const formattedTime = formatDateTime(assess.timeCreate);
        commentList.push({
          courseName,
          content: assess.assessContent,
          timeCreate: formattedTime,
          color: '#00bcd4'
        });
      }
    });
    newCourseComments.push(...commentList);

    // 获取问题解决情况数据
    const questionResponse = await axios.get('http://localhost:8081/questions/all');
    const questionData = questionResponse.data;
    let solvedCount = 0;
    let unsolvedCount = 0;
    questionData.forEach((item: { solve: boolean; }) => {
      if (item.solve === true) {
        solvedCount++;
      } else {
        unsolvedCount++;
      }
    });
    questionSolveData.solved = solvedCount;
    questionSolveData.unsolved = unsolvedCount;

    // 获取课程完成度数据
    const progressResponse = await axios.get('http://localhost:8081/progress/all');
    const progressData = progressResponse.data;
    
    // 按用户分组统计完成情况
    const userProgressMap = new Map<string, {total: number, completed: number}>();
    progressData.forEach((item: { 
      userId: string; 
      isFinished: number;
      timeCreate: string 
    }) => {
      if (!userProgressMap.has(item.userId)) {
        userProgressMap.set(item.userId, {total: 0, completed: 0});
      }
      const userProgress = userProgressMap.get(item.userId)!;
      userProgress.total++;
      if (item.isFinished === 1) {
        userProgress.completed++;
      }
    });

    // 计算每日完成率
    const dateSet = new Set<string>();
    const dateProgressMap = new Map<string, {total: number, completed: number}>();
    
    progressData.forEach((item: { 
      timeCreate: string;
      isFinished: number 
    }) => {
      const date = item.timeCreate.split(' ')[0];
      dateSet.add(date);
      if (!dateProgressMap.has(date)) {
        dateProgressMap.set(date, {total: 0, completed: 0});
      }
      const dateProgress = dateProgressMap.get(date)!;
      dateProgress.total++;
      if (item.isFinished === 1) {
        dateProgress.completed++;
      }
    });

    // 按日期排序
    const sortedDates = Array.from(dateSet).sort();
    const xAxisData = sortedDates;
    const seriesData = sortedDates.map(date => {
      const progress = dateProgressMap.get(date)!;
      return progress.total > 0 ? (progress.completed / progress.total * 100) : 0;
    });

    // 更新图表数据
    courseCompletionLineChartOption.xAxis.data = xAxisData;
    Object.assign(courseCompletionLineChartOption.series[0], {
      data: seriesData,
      type: 'line',
      smooth: true,
      areaStyle: {
        color: {
          type: 'linear',
          x: 0,
          y: 0,
          x2: 0,
          y2: 1,
          colorStops: [{
            offset: 0,
            color: 'rgba(58, 77, 233, 0.8)'
          }, {
            offset: 1,
            color: 'rgba(58, 77, 233, 0.1)'
          }]
        }
      },
      itemStyle: {
        color: '#3a4de9'
      }
    });
  } catch (error) {
    console.error('获取数据失败', error);
  }
});

// 格式化时间函数
const formatDateTime = (dateArray: string | any[]) => {
  if (Array.isArray(dateArray) && dateArray.length === 6) {
    return `${dateArray[0]}-${dateArray[1].toString().padStart(2, '0')}-${dateArray[2].toString().padStart(2, '0')} ${dateArray[3].toString().padStart(2, '0')}:${dateArray[4].toString().padStart(2, '0')}`;
  }
  return '';
};

// 监听课程完成度数据变化，重新渲染图表
watch(
  [
    () => newCourseComments,
    () => popularCoursesRanks,
    () => courseTypeData,
    () => questionSolveData,
    () => courseCompletionLineChartOption,
  ],
  () => {
    // 这里不需要手动调用setOption，v-chart会自动响应数据变化重新渲染
  },
  { deep: true }
);
</script>

<style>
* {
  margin: 0;
  padding: 0;
  outline: 0 !important;
}

.mgb20 {
  margin-bottom: 20px;
}

.card-body {
  display: flex;
  align-items: center;
  height: 100px;
  padding: 0 !important;
}

.card-icon {
  font-size: 50px !important;
  width: 100px !important;
  height: 120px !important;
  text-align: center !important;
  line-height: 100px !important;
  color: #f2f2f2 !important;
}

.card-content {
  text-align: center;
  font-size: 16px;
  padding: 0 35px;
}

.card-num {
  font-size: 28px;
}

.card-header {
  padding-left: 10px;
  margin-bottom: 20px;
}

.card-header-title {
  font-size: 18px;
  font-weight: bold;
}

.card-header-desc {
  font-size: 14px;
  color: #999;
}

.bg1 {
  background: #2d8cf0;
}

.bg2 {
  background: #54a25e;
}

.bg3 {
  background: #f25e43;
}

.bg4 {
  background: #e9a745;
}

.color1 {
  color: #2d8cf0;
}

.color2 {
  color: #54a25e;
}

.color3 {
  color: #f25e43;
}

.color4 {
  color: #e9a745;
}

.chart {
  width: 100%;
  height: 400px;
}

.timeline-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-size: 16px;
  color: #000;
}

.timeline-time,
.timeline-desc {
  font-size: 12px;
  color: #999;
}

.rank-item {
  display: flex;
  align-items: center;
  margin-bottom: 20px;
}

.rank-item-avatar {
  background-color: #f2f2f2;
  width: 40px;
  height: 40px;
  border-radius: 50%;
  text-align: center;
  line-height: 40px;
}

.rank-item-content {
  flex: 1;
  padding-left: 8px;
}

.rank-item-top {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 10px;
  color: #343434;
}

.rank-item-title {
  font-family: SimHei;
}

.rank-item-desc {
  font-size: 14px;
  color: #999;
}
</style>