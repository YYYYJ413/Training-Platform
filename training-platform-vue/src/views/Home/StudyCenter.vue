<template>
    <div id="studycenter">
        <head-tabar></head-tabar>
        <div class="road">
            <div class="user-info-container">
                <div class="user-basic">
                    <img :src="userInfo.avatar" class="user-avatar" alt="用户头像">
                    <div class="user-details">
                        <h3>{{ userInfo.userName }}</h3>
                        <p>{{ userInfo.department }}</p>
                        <p>
                            {{ userInfo.userGender === 0 ? '男' : userInfo.userGender === 1 ? '女' : '未知' }}
                            | {{ userInfo.userNumber }}
                        </p>
                    </div>

                </div>
                <div class="study-stats">
                    <div class="stat-item">
                        <span class="stat-value">学习时长</span>
                        <span class="stat-value">{{ studyHours }}小时</span>
                    </div>
                    <div class="stat-item">
                        <span class="stat-value">获得学分</span>
                        <span class="stat-value">{{ credits }}分</span>
                    </div>
                </div>
            </div>
            <div class="main-content">
                <!-- 左侧菜单 -->
                <div class="left-menu">
                    <el-menu :default-active="activeMenu" @select="handleMenuSelect">
                        <el-menu-item index="1">
                            <i class="bi bi-journal-bookmark"></i>
                            <span>我的课单</span>
                        </el-menu-item>
                        <el-menu-item index="3">
                            <i class="bi bi-journal-check"></i>
                            <span>我的考试</span>
                        </el-menu-item>
                        <el-menu-item index="4">
                            <i class="bi bi-person"></i>
                            <span>个人信息</span>
                        </el-menu-item>

                    </el-menu>
                </div>

                <!-- 中间内容 -->
                <div class="center-content">
                    <el-tabs v-model="activeTab">
                        <el-tab-pane label="在学课程" name="learning" v-if="activeMenu === '1'">
                            <div class="course-list">
                                <el-row :gutter="20">
                                    <el-col :span="24" v-for="(course, index) in paginatedCourses" :key="index">
                                        <el-card shadow="hover" class="horizontal-course-card"
                                            @click="goToCourseDetail(course)">
                                            <div class="horizontal-card-content">
                                                <img :src="course.courseCover" class="horizontal-card-image" alt="课程图片">
                                                <div class="horizontal-card-info">
                                                    <h4>{{ course.courseName }}</h4>
                                                    <div class="card-meta"
                                                        style="display: flex; flex-direction: column; align-items: flex-start;">
                                                        <span><i class="bi bi-tags"></i>&nbsp;老师： {{
                                                            course.courseTeacher
                                                            }} · 共{{ course.lessonCount }}节 </span>
                                                        <div style="margin-top: 8px;">
                                                            <span> {{ course.subscriberCount }}人学习</span>
                                                            <span v-if="course.courseType === 0" class="card-badge">公选</span>
                                                            <span v-else-if="course.courseType === 1" class="card-badge">必修</span>    
                                                        </div>
                                                        
                                                    </div>
                                                </div>
                                                <el-progress type="circle" :percentage="course.progress || 0"
                                                    :width="70" :stroke-width="9" />
                                            </div>
                                        </el-card>
                                    </el-col>
                                </el-row>
                            </div>
                            <el-pagination background layout="total,prev, pager, next" :total="courses.length"
                                :page-sizes="3" :page-size="coursePage.pageSize" @current-change="handleCourseChange"
                                :current-page="coursePage.currentPage" style="float: right;" />
                        </el-tab-pane>

                        <el-tab-pane label="全部考试" name="exams" v-if="activeMenu === '3'">
                            <div class="course-list">
                                <el-table :data="paginatedExams" :default-sort="{ prop: 'examId', order: 'ascending' }"
                                    style="width: 100%;" :row-style="{height:'45px'}">
                                    <el-table-column prop="examId" label="序号" width="80" sortable></el-table-column>
                                    <el-table-column prop="examName" label="考试名称"></el-table-column>
                                    <el-table-column prop="courseName" label="所属课程" sortable></el-table-column>
                                    <el-table-column prop="score" label="得分" width="70" align="center">
                                        <template #default="scope">
                                            <span v-if="scope.row.score === -1">/</span>
                                            <span v-else>{{ scope.row.score }}</span>
                                        </template>
                                    </el-table-column>

                                    <el-table-column prop="duration" label="考试时长" width="100"
                                        align="center"></el-table-column>
                                    <el-table-column prop="retakeAllowed" label="剩余考试次数" width="110"
                                        align="center"></el-table-column>

                                    <!--                                  <el-table-column label="操作" width="150">-->
                                    <!--                                    <template #default="scope">-->
                                    <!--                                      <span v-if="scope.row.score >= scope.row.passMark" style="color: green;">已通过</span>-->
                                    <!--                                      <el-link v-else-if="scope.row.retakeAllowed > 0" type="danger" @click="retakeExam(scope.row)">重考</el-link>-->
                                    <!--                                      <el-link v-else-if="scope.row.score === -1" type="primary" @click="startExam(scope.row.examId)">开始考试</el-link>-->
                                    <!--                                      <span v-else style="color: gray;">未通过</span>-->
                                    <!--                                    </template>-->
                                    <!--                                  </el-table-column>-->

                                    <el-table-column label="操作" width="150">
                                        <template #default="scope">
                                            <el-link v-if="scope.row.score === -1" type="primary"
                                                @click="startExam(scope.row.examId)">开始考试</el-link>
                                            <span v-else-if="scope.row.score >= scope.row.passMark"
                                                style="color: green;">已通过</span>
                                            <el-link v-else-if="scope.row.retakeAllowed > 0" type="danger"
                                                @click="retakeExam(scope.row.examId)">重考</el-link>
                                            <span v-else style="color: gray;">未通过</span>
                                        </template>
                                    </el-table-column>


                                </el-table>
                                <el-pagination background layout="total,prev, pager, next" :total="exams.length"
                                    :page-size="examPageSize" :current-page="examCurrentPage"
                                    @current-change="handleExamPageChange" style="margin-top: 10px;float: right;" />
                            </div>
                        </el-tab-pane>

                        <!-- 个人信息 -->
                        <el-tab-pane label="个人信息" name="info" v-if="activeMenu === '4'">
                            <div class="info-container">
                                <el-form :model="userInfo" label-width="80px">
                                    <el-form-item label="头像">
                                        <el-upload action="#" list-type="picture-card" :show-file-list="false"
                                            :before-upload="beforeAvatarUpload" :on-change="handleAvatarChange"
                                            :auto-upload="false">
                                            <img v-if="userInfo.avatar" :src="userInfo.avatar" class="avatar"
                                                style="width: 120px; height: 120px;" />
                                            <img v-else :src="defaultAvatar" class="avatar"
                                                style="width: 120px; height: 120px;" />
                                            <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                                        </el-upload>
                                    </el-form-item>
                                    <el-form-item value="姓名" label="姓名">
                                        <el-input v-model="userInfo.userName" placeholder="请输入姓名" />
                                    </el-form-item>
                                    <el-form-item value="账号" label="账号">
                                        <el-input v-model="userInfo.userNumber" placeholder="请输入账号" />
                                    </el-form-item>

                                    <el-form-item value="密码" label="密码">
                                        <el-input v-model="userInfo.userPassword" placeholder="请输入密码" type="password" />
                                    </el-form-item>
                                    <el-form-item value="性别" label="性别">
                                        <el-radio-group v-model="userInfo.userGender">
                                            <el-radio :value="0">男</el-radio>
                                            <el-radio :value="1">女</el-radio>
                                        </el-radio-group>
                                    </el-form-item>

                                    <el-form-item value="部门" label="部门">
                                        <el-input v-model="userInfo.department" placeholder="请输入部门" />
                                    </el-form-item>
                                    <el-form-item value="联系方式" label="联系方式">
                                        <el-input v-model="userInfo.contactInfo" placeholder="请输入联系方式" />
                                    </el-form-item>

                                    <el-form-item>
                                        <el-button type="primary" @click="saveInfo" :loading="saving">保存</el-button>
                                        <el-button @click="cancelEdit">取消</el-button>
                                    </el-form-item>
                                </el-form>
                            </div>
                        </el-tab-pane>

                    </el-tabs>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import { ref, computed, onMounted, watch } from 'vue';
import HeadTabar from '../../components/HomeTaber/HeadTabar.vue';
import { useStore } from 'vuex';
import { ElMessage, ElMessageBox } from 'element-plus';
import { getMyCourse, getMyExam } from '../../api';
import { useRoute, useRouter } from 'vue-router';
import axios from 'axios';

export default {
    name: "StudyCenter",
    components: {
        HeadTabar
    },
    created() {

    },
    setup() {
        const saving = ref(false);
        const studyHours = ref(0); // 学习时长
        const credits = ref(0); // 学分
        const points = ref(0); // 积分
        const isEditing = ref(false); // 编辑模式
        const store = useStore();
        const router = useRouter();
        const route = useRoute();
        const defaultAvatar = ref('https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png');
        const userInfo = ref({
            userId: store.getters.userId,
            userName: store.getters.userName,
            userNumber: store.getters.userNumber,
            userPassword:store.getters.userPassword,
            contactInfo: store.getters.contactInfo,
            userGender: store.getters.userGender,
            department: store.getters.department || 'null',
            avatar: store.getters.userImg||defaultAvatar.value
        });
        
        const courses = ref([]);
        const exams = ref([]);
        const activeMenu = ref('1');
        const activeTab = computed(() => {
            switch (activeMenu.value) {
                case '1': return 'learning';
                case '3': return 'exams';
                case '4': return 'info';
                default: return 'learning';
            }
        });
        const coursePage = ref({
            pageSize: 4,
            total: courses.length,
            currentPage: 1
        });
        const pageSize = ref(6);
        const currentPage = ref(1);
        const examPageSize = ref(10);
        const examCurrentPage = ref(1);

        const paginatedCourses = computed(() => {
            const start = (coursePage.value.currentPage - 1) * coursePage.value.pageSize;
            const end = start + coursePage.value.pageSize;
            return courses.value.slice(start, end);
        });

        const paginatedExams = computed(() => {
            const start = (examCurrentPage.value - 1) * examPageSize.value;
            const end = start + examPageSize.value;
            return exams.value.slice(start, end);
        });

        const fetchUserInfo = () => {
            const userId = userInfo.value.userId;
            fetch(`http://localhost:8081/bg/users/${userId}`)
                .then(response => response.json())
                .then(data => {
                    userInfo.value = {
                        ...data,
                        avatar: userInfo.value.avatar || defaultAvatar.value
                    };
                })
                .catch(error => {
                    console.error("Error fetching user info:", error);
                });
        };

        const fetchCourseInfo = async () => {
            if (!store.getters.token) {
                ElMessage.error('请登录');
            } else {
                try {
                    const res = await getMyCourse(userInfo.value.userId);
                    courses.value = res.data.data;

                    // 为每个课程获取节数和计算进度
                    for (const course of courses.value) {
                        const countRes = await axios.get(
                            `http://localhost:8081/section/countChapterIds/${course.courseId}`
                        );
                        course.lessonCount = countRes.data;

                        const response = await axios.get(
                            `http://localhost:8081/ucourse/count/${course.courseId}`
                        );
                        course.subscriberCount = response.data;

                        // 获取章节数据
                        const chapterResponse = await axios.get(`http://localhost:8081/section/show?courseId=${course.courseId}`);
                        const chapterData = chapterResponse.data; // 假设返回的章节数据

                        const maxChapterResponse = await axios.get(`http://localhost:8081/section/maxChapterBelong/${course.courseId}`);
                        const maxChapter = maxChapterResponse.data; // 获取最大单元数

                        let totalSections = 0; // 总节数
                        let completedSections = 0; // 已完成节数

                        for (let i = 1; i <= maxChapter; i++) {
                            const sections = chapterData
                                .filter(section => section.chapterBelong === i)
                                .sort((a, b) => a.chapterOrder - b.chapterOrder);

                            for (const section of sections) {
                                // 使用 getCompletionStatus 函数获取每节的完成状态
                                section.completed = await getCompletionStatus(course.courseId,section.chapterId);
                                totalSections++;
                                if (section.completed) {
                                    completedSections++;
                                }
                            }

                            // 计算当前章节的进度
                            const progress = sections.length > 0 ?
                                (sections.reduce((acc, section) => acc + (section.completed ? 1 : 0), 0) / sections.length) * 100 : 0;

                            // 可以将 progress 存储到课程对象中或章节对象中
                            // 这里我们可以选择不单独存储章节进度
                        }

                        // 计算课程的整体进度
                        course.progress = totalSections > 0 ?
                            parseFloat((completedSections / totalSections * 100).toFixed(2)) : 0;
                    }
                } catch (error) {
                    console.error("获取课程信息失败:", error);
                }
            }
        };

        const getCompletionStatus = async (courseId,chapterId) => {
            const userId = userInfo.value.userId; // 使用指定的用户ID
            const response = await axios.get(`http://localhost:8081/progress/status?userId=${userId}&courseId=${courseId}&chapterId=${chapterId}`);
            return response.data; // 返回boolean值，表示该章节是否完成
        };
        const fetchExamInfo = async () => {
            if (!store.getters.token) {
                ElMessage.error('请登录');
            } else {
                try {
                    const res = await getMyExam(userInfo.value.userId);
                    exams.value = res.data.data;

                    // Fetch the maximum score and pass mark for each exam
                    for (const exam of exams.value) {
                        exam.score = await getMaxScore(exam.examId, userInfo.value.userId);
                        exam.retakeAllowed = await fetchRemainingRetakes(exam.examId);
                        exam.passMark = await fetchPassMark(exam.examId); // Get the pass mark
                    }
                } catch (error) {
                    console.error("获取考试信息失败:", error);
                }
            }
        };

        const fetchPassMark = async (examId) => {
            try {
                const response = await axios.get(`http://localhost:8081/examinfo/info?examId=${examId}`);
                return response.data.passMark; // 假设返回的数据包含 passMark
            } catch (error) {
                console.error(`Error fetching pass mark for examId ${examId}:`, error);
                return 0; // 返回0或其他默认值以防出现错误
            }
        };

        const fetchRemainingRetakes = async (examId) => {
            const userId = userInfo.value.userId; // 使用固定的用户ID
            try {
                const response = await axios.get(`http://localhost:8081/examinfo/remainingRetakes?examId=${examId}&userId=${userId}`);
                return response.data; // 剩余考试次数
            } catch (error) {
                console.error(`Error fetching remaining retakes for examId ${examId}:`, error);
                return 0; // 返回0或其他默认值以防出现错误
            }
        };

        const getMaxScore = async (examId, userId) => {
            try {
                const response = await axios.get(`http://localhost:8081/examinfo/maxScore?examId=${examId}&userId=${userId}`);
                return response.data; // Assuming the response contains the score directly
            } catch (error) {
                console.error(`Error fetching max score for examId ${examId}:`, error);
                return null; // Return null or a default value in case of error
            }
        };


        const loadSubscriberCount = async (courseId) => {
            const response = await axios.get(`http://localhost:8081/ucourse/count/${courseId}`);
            this.subscriberCount = response.data; // 假设返回的数值为学习人数
        };

        const getLessonCount = async (courseId) => {
            const response = await axios.get(`http://localhost:8081/section/countChapterIds/${courseId}`);
            return response.data; // 假设返回的数值为总节数
        };

        const beforeAvatarUpload = (file) => {
            const isJPG = file.type === 'image/jpeg' || file.type === 'image/png';
            const isLt2M = file.size / 1024 / 1024 < 2;

            if (!isJPG) {
                ElMessage.error('上传头像图片只能是 JPG/PNG 格式!');
            }
            if (!isLt2M) {
                ElMessage.error('上传头像图片大小不能超过 2MB!');
            }
            return isJPG && isLt2M;
        };

        const handleAvatarChange = (file) => {
            const reader = new FileReader();
            reader.onload = (e) => {
                userInfo.value.avatar = e.target.result;
            };
            reader.readAsDataURL(file.raw);
        };

        const saveInfo = async () => {
            const userId = userInfo.value.userId;
            saving.value = true;

            try {
                // 1. 如果有新头像，先上传头像
                if (userInfo.value.avatar && userInfo.value.avatar.startsWith('data:')) {
                    try {
                        const formData = new FormData();
                        const blob = await fetch(userInfo.value.avatar).then(r => r.blob());
                        formData.append('file', blob, 'avatar.png');

                        const uploadRes = await axios.post(
                            `http://localhost:8081/bg/users/${userId}/avatar`,
                            formData,
                            {
                                headers: {
                                    'Content-Type': 'multipart/form-data'
                                }
                            }
                        );

                        if (uploadRes.data && uploadRes.data.url) {
                            userInfo.value.avatar = uploadRes.data.url;
                        }
                    } catch (uploadError) {
                        console.error("头像上传失败:", uploadError);
                        ElMessage.warning('头像上传失败，将继续保存其他信息');
                    }
                }

                // 2. 使用Vuex action更新用户信息
                await store.dispatch('updateUser', {
                    userId: userInfo.value.userId,
                    userName: userInfo.value.userName,
                    userNumber: userInfo.value.userNumber,
                    userGender: userInfo.value.userGender,
                    contactInfo: userInfo.value.contactInfo,
                    userImg: userInfo.value.avatar
                });
                // console.log(userInfo.value.avatar);
                ElMessage.success('个人信息保存成功');
            } catch (error) {
                console.error("保存失败:", error);
                ElMessage.error('保存失败: ' + (error.response?.data?.message || error.message || '未知错误'));
            } finally {
                saving.value = false;
            }
        };

        const cancelEdit = () => {
            ElMessage.info('已取消编辑');
            // fetchUserInfo();
        };

        const startExam = (id) => {
            ElMessageBox.confirm('确认开始考试？', '提示', {
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'info'
            }).then(() => {
                // 跳转到考试页面
                router.push({
                    name: 'ExamPage',
                    params: { id }
                })
            });
        };
        const retakeExam = (id) => {
            ElMessageBox.confirm('确认开始考试？', '提示', {
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'info'
            }).then(() => {
                // 跳转到考试页面
                router.push({
                    name: 'ExamPage',
                    params: { id }
                })
            });
        }

        const handleCourseChange = (val) => {
            coursePage.value.currentPage = val;
        };
        const handleExamPageChange = (val) => {
            examCurrentPage.value = val;
        }

        const handleMenuSelect = (index) => { 
            // 更新路由但不触发组件重新加载
            router.push({
                path: `/studycenter/${index}`,
                params: { index }
            });

            // 不需要手动设置 activeTab，因为它是计算属性
        };

        const goToCourseDetail = (course) => {
            // 跳转到课程详情页面
            router.push(`/course/${course.courseId}`);
        };

        const fetchTotalInfo = async () => {
            const userId = userInfo.value.userId;
            try {
                const videoLinksResponse = await axios.get(`http://localhost:8081/progress/finished-chapters/${userId}`);
                const videoLinks = videoLinksResponse.data;

                // 假设每个视频的时长为10分钟（你需要根据实际情况计算）
                studyHours.value = ((videoLinks.length * 10) / 60).toFixed(2); // 转换为小时

                // 更新学分
                const countResponse = await axios.get(`http://localhost:8081/progress/finished-count/${userId}`);
                credits.value = countResponse.data * 2;

            } catch (error) {
                console.error("获取课程信息失败:", error);
            }
        };

        onMounted(() => {
            // fetchUserInfo();
            fetchCourseInfo();
            fetchExamInfo();
            fetchTotalInfo();
        })

        watch(() => route.params.index, (newIndex) => {
            if (newIndex) {
                
                activeMenu.value = newIndex;
                console.log(activeMenu.value);
                if (activeMenu.value === 1) {
                    activeTab = 'learning';
                }
                else if (activeMenu.value === 3) {
                    activeTab = 'exams';
                }
                else if (activeMenu.value === 4) {
                    activeTab = 'info';
                }
            }
        }, { immediate: true }
        );

        return {
            coursePage,
            saving,
            studyHours,
            credits,
            points,
            userInfo,
            defaultAvatar,
            courses,
            exams,
            activeMenu,
            activeTab,
            pageSize,
            currentPage,
            examPageSize,
            examCurrentPage,
            paginatedCourses,
            paginatedExams,
            // fetchUserInfo,
            fetchExamInfo,
            beforeAvatarUpload,
            handleAvatarChange,
            saveInfo,
            cancelEdit,
            startExam,
            retakeExam,
            handleCourseChange,
            handleExamPageChange,
            handleMenuSelect,
            goToCourseDetail,
            getLessonCount,
            loadSubscriberCount,
            fetchTotalInfo
        };
    }
};
</script>

<style scoped>
#studycenter {
    height: auto;
    width: auto;
    padding: 20px;
    background: #ebeef5;
    margin: 70px auto 0;
}

.road {
    width: 1200px;
    margin: 0 auto;
    min-height: 631px;
}

.card-badge {
    margin-left: 20px;
    background: #4dbeffd7;
    color: white;
    padding: 2px 8px;
    width: 50px;
    border-radius: 10px;
    font-size: 12px;
    z-index: 1;
}

/* 中间内容 */
.card-meta {
    display: flex;
    justify-content: start;
    font-size: 12px;
    color: #666;
}

/* 用户信息 */
.user-info-container {
    display: flex;
    justify-content: space-between;
    align-items: center;
    background: #fff;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
    margin-bottom: 20px;
}

.user-basic {
    display: flex;
    align-items: center;
}

.user-avatar {
    width: 80px;
    height: 80px;
    border-radius: 50%;
    margin-right: 20px;
    object-fit: cover;
}

.user-details h3 {
    margin: 0 0 8px 0;
    font-size: 18px;
    color: #333;
}

.user-details p {
    margin: 5px 0;
    font-size: 14px;
    color: #666;
}

.study-stats {
    display: flex;
    gap: 30px;
}

.stat-item {
    text-align: center;
}

.stat-value {
    display: block;
    font-size: 14px;
    color: #999;
    margin-bottom: 8px;
}

.stat-value {
    font-size: 20px;
    font-weight: bold;
    color: #409EFF;
}

.main-content {
    display: flex;
    margin-top: 20px;
    gap: 20px;
}

/* 左边 */
.left-menu {
    width: 200px;
    background: #fff;
    border-radius: 8px;
    padding: 10px 0;
}

/* 中间 */
.center-content {
    flex: 1;
    background: #fff;
    border-radius: 8px;
    padding: 20px;
}

/* 右表 */
.right-sidebar {
    width: 200px;
}

.ranking,
.recommendations {
    background: #fff;
    border-radius: 8px;
    padding: 15px;
    margin-bottom: 20px;
}

/* 在学课程 */
.course-list {
    margin-bottom: 20px;
}

/* 中间卡片 */
.horizontal-course-card {
    margin-bottom: 6px;
    cursor: pointer;
}

.horizontal-card-content {
    display: flex;
    align-items: flex-start;
    padding: 10px;
}

.horizontal-card-image {
    width: 120px;
    height: 80px;
    object-fit: cover;
    margin-right: 20px;
    border-radius: 9px;
}

/* 卡片内容 */
.horizontal-card-info {
    flex: 1;
    padding-right: 20px;
    text-align: left;
}

.horizontal-card-info h4 {
    margin: 0 0 8px 0;
    font-size: 16px;
    color: #333;
}
</style>