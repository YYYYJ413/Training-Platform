<template>
    <div class="paperlist" style="padding: 15px;">
        <!-- 面包屑导航 -->
        <el-breadcrumb separator-class="el-icon-arrow-right">
            <el-breadcrumb-item :to="{ path: '/HomePage' }">首页</el-breadcrumb-item>
            <el-breadcrumb-item>试卷管理</el-breadcrumb-item>
            <el-breadcrumb-item>试卷列表</el-breadcrumb-item>
        </el-breadcrumb>
        <el-card>
            <el-row>
                <el-col :span="24">
                    <span style="margin:10px;">试卷名称</span>
                    <el-input v-model="queryInfo.paperName" placeholder="请输入试卷名称" style="width:200px"></el-input>
                    <span style="white-space: nowrap;margin: 10px;">课程分类</span>
                    <el-select v-model="queryInfo.courseId" placeholder="请选择课程" @change="loadExamsByCourse"
                        style="width: 200px;">
                        <el-option v-for="item in courseOptions" :key="item.value" :value="item.value"
                            :label="item.label"></el-option>
                    </el-select>
                    <el-button type="primary" @click="resetQuery">重置</el-button>
                    <el-button type="primary" @click="addPaperDrawer = true">添加试卷</el-button>
                </el-col>
            </el-row>

            <el-row :gutter="20">
                <el-col :span="24">
                    <div style="height: 20px;"></div>
                </el-col>
            </el-row>
            <!-- 试卷列表 -->
            <el-table :data="paperList" style="width: 100%" border>
                <el-table-column prop="id" label="序号" width="70"></el-table-column>
                <el-table-column prop="papername" label="试卷名称"></el-table-column>
                <el-table-column prop="courseName" label="所属课程"></el-table-column>
                <el-table-column prop="itemCount" label="题目数" width="70"></el-table-column>
                <el-table-column prop="totalScore" label="总分" width="70"></el-table-column>
                <el-table-column prop="createTime" label="创建时间"></el-table-column>
                <el-table-column prop="updateTime" label="更新时间"></el-table-column>
                <el-table-column label="操作" width="170">
                    <template #default="scope">
                        <div style="display: grid;grid-template-columns: 1fr 1fr ;gap: 5px; width: 100%;">
                            <el-button type="primary" size="small" @click="ViewPapers(scope.row)">
                                <el-icon>
                                    <View />
                                </el-icon>预览
                            </el-button>
                            <el-button type="warning" size="small" @click="EditPaper(scope.row)">
                                <el-icon>
                                    <Edit />
                                </el-icon>编辑
                            </el-button>
                            <el-button type="danger" size="small" @click="DeletePaper(scope.row)">
                                <el-icon>
                                    <Delete />
                                </el-icon>删除
                            </el-button>
                        </div>

                    </template>
                </el-table-column>
            </el-table>
            <!-- 分页 -->
            <el-pagination @size-change="handleSizechange" @current-change="handleCurrentChange"
                :current-page="queryInfo.pagenum" :page-sizes="[5, 10, 15, 20]" :page-size="queryInfo.pagesize"
                layout="total,sizes,prev,pager,next,jumper" :total="queryInfo.total"
                style="float: right; margin: 15px;">
            </el-pagination>
        </el-card>
        <!-- 试卷添加抽屉 -->
        <el-drawer v-model="addPaperDrawer" size="70%" direction="rtl" :before-close="handleDrawerClose">
            <template #header>
                <h2 style="font-weight: bold; text-align: left;">{{ drawerTitle }}</h2>
            </template>
            <div style="padding: 20px; max-height: 80vh; overflow-y: auto;">
                <el-tabs v-model="activeTab">
                    <el-tab-pane label="基本信息" name="basic">
                        <el-form label-width="100px">
                            <el-form-item label="试卷名称">
                                <el-input v-model="currentPaper.name" placeholder="请输入试卷名称" style="width: 300px;" />
                            </el-form-item>
                            <el-form-item label="试卷所属课程">
                                <el-select v-model="currentPaper.courseId" placeholder="请选择试卷所属课程"
                                    style="width: 300px;">
                                    <el-option v-for="item in courseOptions" :key="item.value" :value="item.value"
                                        :label="item.label"></el-option>
                                </el-select>
                            </el-form-item>
                            <!-- <el-form-item label="总分">
                                <el-input-number v-model="currentPaper.totalScore" :min="0" :max="200" />分
                            </el-form-item> -->
                            <el-divider />

                            <h3>题型数量设置</h3>
                            <el-form-item label="单选题">
                                <el-input-number v-model="currentPaper.singleNum" :min="0" :max="50" />题
                            </el-form-item>
                            <el-form-item label="多选题">
                                <el-input-number v-model="currentPaper.multiNum" :min="0" :max="50" />题
                            </el-form-item>
                            <el-form-item label="判断题">
                                <el-input-number v-model="currentPaper.judgmentNum" :min="0" :max="100" />题
                            </el-form-item>
                            <el-form-item label="填空题">
                                <el-input-number v-model="currentPaper.compleNum" :min="0" :max="100" />题
                            </el-form-item>
                            <el-form-item label="问答题">
                                <el-input-number v-model="currentPaper.subNum" :min="0" :max="100" />题
                            </el-form-item>
                        </el-form>
                        <el-button type="success" style="float: left;margin-left: 50px;" @click="submitAuto">自动组卷</el-button>
                    </el-tab-pane>
                    <el-tab-pane label="试题管理" name="questions">
                        <div style="margin-bottom: 20px;">
                            <el-button type="primary" @click="addQuestionDialog = true">从题库添加</el-button>
                            <el-button type="danger" @click="batchDeleteQuestions">批量删除</el-button>
                        </div>
                        <el-table :data="currentPaper.questions" border style="width: 100%;"
                            @selection-change="handleSelectChange">
                            <el-table-column type="selection" width="55" />
                            <el-table-column prop="itemContent" label="题目内容" />
                            <el-table-column label="题型">
                                <template #default="scope">
                                    {{ getQuestionType(scope.row.itemType).simpleName }}
                                </template>
                            </el-table-column>
                            <el-table-column prop="itemScore" label="分值" />
                            <el-table-column label="答案">
                                <template #default="scope">
                                    {{ getAnswer(scope.row) }}
                                </template>
                            </el-table-column>
                            <el-table-column prop="timeCreate" label="创建时间" />
                        </el-table>
                    </el-tab-pane>
                </el-tabs>

                <div style="margin-top: 20px; text-align: right;">
                    <el-button type="primary" @click="saveAndPublish">保存并发布</el-button>
                    <el-button @click="previewPaper">预览</el-button>
                </div>
            </div>
        </el-drawer>

        <!-- 编辑试卷 -->
        <el-drawer v-model="editPaperDrawer" size="70%" direction="rtl" :before-close="handleDrawerClose">
            <template #header>
                <h2 style="font-weight: bold; text-align: left;">编辑试卷</h2>
            </template>
            <div style="padding: 20px; max-height: 80vh; overflow-y: auto;">
                <el-tabs v-model="activeTab">
                    <el-tab-pane label="基本信息" name="basic">
                        <el-form label-width="100px">
                            <el-form-item label="试卷名称">
                                <el-input v-model="currentPaper.papername" placeholder="请输入试卷名称" />
                            </el-form-item>
                            <el-form-item label="试卷所属课程">
                                <el-select v-model="currentPaper.courseId" placeholder="请选择所属课程">
                                    <el-option v-for="item in courseOptions" :key="item.value" :value="item.value"
                                        :label="item.label"></el-option>
                                </el-select>
                            </el-form-item>
                            <el-form-item label="总分">
                                <p>{{ currentPaper.totalScore }}分</p>
                            </el-form-item>
                            <!-- <el-divider />
                            <h3>题型分值设置</h3>
                            <el-form-item label="单选题">
                                <el-input-number v-model="currentPaper.singleChoiceScore" :min="0" :max="100" />分每题
                            </el-form-item>
                            <el-form-item label="多选题">
                                <el-input-number v-model="currentPaper.multiChoiceScore" :min="0" :max="100" />
                            </el-form-item>
                            <el-form-item label="判断题">
                                <el-input-number v-model="currentPaper.judgmentScore" :min="0" :max="100" />
                            </el-form-item>
                            <el-form-item label="问答题">
                                <el-input-number v-model="currentPaper.essayScore" :min="0" :max="100" />
                            </el-form-item> -->
                        </el-form>
                    </el-tab-pane>
                    <el-tab-pane label="试题管理" name="questions">
                        <div style="margin-bottom: 20px;">
                            <el-button type="primary" @click="addQuestionDialog = true">从题库添加</el-button>
                            <el-button type="danger" @click="batchDeleteQuestions">批量删除</el-button>
                        </div>
                        <el-table :data="currentPaper.questions" border style="width: 100%;"
                            @selection-change="handleSelectChange">
                            <el-table-column type="selection" width="55" />
                            <el-table-column prop="itemContent" label="题目内容" width="250" />
                            <el-table-column label="题型" width="80">
                                <template #default="scope">
                                    {{ getQuestionType(scope.row.itemType).simpleName }}
                                </template>
                            </el-table-column>
                            <el-table-column prop="itemScore" label="分值" width="80" />
                            <el-table-column label="答案">
                                <template #default="scope">
                                    {{ getAnswer(scope.row) }}
                                </template>
                            </el-table-column>
                            <el-table-column prop="timeModify" label="更新时间" width="200" />
                        </el-table>
                    </el-tab-pane>
                </el-tabs>

                <div style="margin-top: 20px; text-align: right;">
                    <el-button type="primary" @click="saveEdit">保存</el-button>
                </div>
            </div>
        </el-drawer>

        <!-- 从题库添加试题 -->
        <el-dialog title="从题库添加试题" v-model="addQuestionDialog" width="80%">
            <el-form label-width="100px">
                <el-form-item label="选择题库">
                    <el-select v-model="selectedBank" placeholder="请选择题库" @change="handleBankChange">
                        <el-option v-for="bank in questionBanks" :key="bank.value" :label="bank.label"
                            :value="bank.value" />
                    </el-select>
                </el-form-item>
                <el-table :data="bankList" border style="width: 100%;" @selection-change="handleSelectionChange">
                    <el-table-column type="selection" width="55" />
                    <el-table-column prop="itemContent" label="题目内容" />
                    <el-table-column label="题型" width="100px">
                        <template #default="scope">
                            {{ getQuestionType(scope.row.itemType).simpleName }}
                        </template>
                    </el-table-column>
                    <el-table-column prop="itemScore" label="分值" width="80" />
                    <el-table-column prop="timeModify" label="更新时间" />
                </el-table>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="cancelAdd">取消</el-button>
                <el-button type="primary" @click="addQuestion">添加</el-button>
            </div>
        </el-dialog>

        <!-- 预览试卷抽屉 -->
        <el-drawer v-model="viewPaper" size="70%" direction="rtl" :before-close="handleDrawerClose">
            <h2 style="text-align: center; margin-bottom: 20px;">{{currentPaper.papername}}</h2>
            <BaseQuestionPreview v-for="(item,index) in previewPaperData" :itemType="item.itemType" :number="index+1"
                :question="item" :options="item.itemOptions" />
            <template #footer>
                <el-button @click="viewPaper = false">关闭</el-button>
                <el-button type="primary" @click="printPaper">打印</el-button>
            </template>
        </el-drawer>

    </div>
</template>

<script>
import { ref, computed, onMounted, shallowRef, reactive } from 'vue';
import { Edit, Location, Search, View, Upload, Delete } from '@element-plus/icons-vue';
import { addPaper, autoMaticPaper, deletePaper, getBankList, getBankQueList, getCourseList, getPaperDetail, getPaperList, updatePaper } from '../../api';
import BaseQuestionPreview from '../BackGround/BaseQuestionPreview.vue';
import { getQuestionType } from '../../enums/questionType';
import { ElMessage, ElMessageBox } from 'element-plus';

export default {
    components: {
        Edit,
        Location,
        Search,
        View,
        Upload,
        Delete,
        BaseQuestionPreview,
    },
    setup() {
        const queryInfo = ref({
            query: '',
            pagenum: 1,
            pagesize: 10,
            total: 0,
            paperName: '',
            courseId:''
        });
        const allData = ref([]);
        const courseOptions = ref([]);
        const addPaperDrawer = ref(false);
        const editPaperDrawer = ref(false);
        const addQuestionDialog = ref(false);
        const drawerTitle = ref('添加试卷');
        const activeTab = ref('basic');
        const currentPaper = ref({
            name: '',
            courseId: '',
            courseName: '',
            totalScore: 0,
            singleNum: 0,
            multiNum: 0,
            judgmentNum: 0,
            compleNum: 0,
            subNum:0,
            questions: []
        });

        const viewPaper = ref(false);
        const previewPaperData = shallowRef([]);  //试卷题目列表

        const loadData = () => {
            getPaperList().then(res => {
                const data = res.data.data;
                allData.value = data.map(paper => ({
                    id: paper.paperId,
                    courseId: paper.courseId,
                    courseName: paper.courseName,
                    papername: paper.paperName,
                    totalScore: paper.totalScore,
                    itemCount: paper.itemCount,
                    createTime: paper.timeCreate,
                    updateTime: paper.timeModify
                }));
                queryInfo.value.total = allData.value.length;
            }).catch(err => {
                console.error('获取试卷数据失败:', err);
            });
        };

        const loadCourseOptions=()=> {
            getCourseList().then((res) => {
                const data = res.data.data;
                courseOptions.value = data.map(item => ({
                    value: item.courseId,
                    label: item.courseName
                }));
                // console.log(this.paperOptions);
            }).catch(err => {
                console.error('获取课程ID列表失败:', err);
                this.$message.error('获取课程ID列表失败，请稍后重试');
            })
        };

        const submitAuto = () => {
            const rule = {
                paperName: currentPaper.value.name,
                singleNum: currentPaper.value.singleNum, // 单选题数量
                multipleNum: currentPaper.value.multiNum, // 多选题数量
                judgmentNum: currentPaper.value.judgmentNum, // 判断题数量
                completionNum: currentPaper.value.compleNum, // 填空题数量
                subjectiveNum: currentPaper.value.subNum,
            };
            const courseId = currentPaper.value.courseId;
            autoMaticPaper(rule, courseId).then(res => {
                // console.log(res.data);
                if (res.data.code === 0 && res.data.data) {
                    ElMessage.success('自动组卷成功');
                    loadData();
                    const paperId = res.data.data[0].paperId;
                    getPaperDetail(paperId).then(res => {
                        if (res.data.code === 0) {
                            currentPaper.value.questions = res.data.data;
                            previewPaper();
                        }
                    }).catch(err => {
                        console.error('获取试卷详情失败:', err);
                        ElMessage.error('获取试卷详情失败，请稍后重试');
                    });
                } else {
                    ElMessage.error(res.data.message);
                }
            }).catch(err => {
                console.log(err);
                ElMessage.error('组卷失败，请检查输入数据是否正确');
            })
        }

        const handleSizechange = (val) => {
            queryInfo.value.pagesize = val;
        };

        const handleCurrentChange = (val) => {
            queryInfo.value.pagenum = val;
        };

        const searchPapers = () => {
            console.log('查询条件:', queryInfo.value);
        };

        const ViewPapers = (row) => {
            currentPaper.value = row;
            // console.log(currentPaper.value);
            getPaperDetail(currentPaper.value.id).then(res => {
                const rawPreviewData = res.data.data;      
                const priorityMap = {
                    "SINGLE_CHOICE": 1,
                    "MULTIPLE_CHOICE": 2,
                    "JUDGEMENT": 3,
                    "COMPLETION": 4,
                    "SUBJECTIVE":5,
                };
                previewPaperData.value = rawPreviewData.sort((a, b) => {
                    return (priorityMap[a.itemType] || 999) - (priorityMap[b.itemType] || 999);
                });
                viewPaper.value = true;
            }).catch(err => {
                console.error('获取试卷详情失败:', err);
                this.$message.error('获取试卷详情失败，请稍后重试');
            });
        };
        //创建试卷时预览
        const previewPaper = () => {
            console.log(currentPaper.value.questions);
            previewPaperData.value = currentPaper.value.questions;
            console.log(previewPaperData.value);
            viewPaper.value = true;
        };

        const PublishPaper = (row) => {
            console.log('发布试卷:', row);
        };

        const EditPaper = (row) => {
            currentPaper.value = row;
            getPaperDetail(currentPaper.value.id).then(res => {
                previewPaperData.value = res.data.data;
                currentPaper.value.questions = res.data.data;
            })
            editPaperDrawer.value = true;
        };

        const DeletePaper = (row) => {
            console.log('删除试卷:', row);
            ElMessageBox.confirm('确定要删除该试卷吗？', '提示', {
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'warning'
            }).then(() => {
                deletePaper(row.id).then(res => {
                    if (res.data.code === 0) {
                        ElMessage.success('删除试卷成功');
                        loadData();
                    } else {
                        ElMessage.error('删除试卷失败');
                    }
                }).catch(error => {
                    console.log(error);
                    ElMessage.error('删除试卷失败，请稍后重试');
                })
            }).catch(() => {
                // 用户取消操作时的处理，这里可以不做额外操作
            });
            
        };

        const handleDrawerClose = () => {
            resetPaperForm();
            addPaperDrawer.value = false;
            editPaperDrawer.value = false;
            viewPaper.value = false;
        };

        const resetPaperForm = () => {
            currentPaper.value = {
                name: '',
                courseId: '',
                courseName: '',
                totalScore: 100,
                singleNum: 0,
                multiNum: 0,
                judgmentNum: 0,
                compleNum: 0,
                subNum: 0,
                questions: []
            };
            activeTab.value = 'basic';
        };

        const getAnswer = (item) => {
            const answer = []
            const itemOptions = item.itemOptions || [];
            itemOptions.forEach((option, index) => {
                if (option.optionAnswer) {
                    if (item.itemType === 'SINGLE_CHOICE' || item.itemType === 'MULTIPLE_CHOICE') {
                        answer.push(option.optionContent);
                    } else {
                        answer.push(option.optionAnswer)
                    }
                }
            })
            if (answer.length == 0) {
                answer.push('略')
            }
            return answer.join('；')
        }

        const questionBanks = ref([]);
        //获取题库选项
        const getQuestionBanks = () => {
            getBankList().then((res) => {
                const data = res.data;
                questionBanks.value = data.map(item => ({
                    value: item.bankId,
                    label: item.bankName
                }));
                // console.log(questionBanks.value);
            }).catch(err => {
                console.error('获取题库ID列表失败:', err);
                this.$message.error('获取题库ID列表失败，请稍后重试');
            })
        }

        const selectedBank = ref([]);
        const chooseList = ref([]);//暂存从题库选择的题目
        const bankList = ref([]);
        const getBankDetail = (id) => {
            getBankQueList(id).then(res => {
                if (res.data.code === 0) {
                    bankList.value = res.data.data;
                } else {
                    ElMessage.error('获取题库题目列表失败，请稍后重试');
                }
            })
        }
        const addQuestion = () => {
            chooseList.value.forEach(item => {
                if (!currentPaper.value.questions.some(q => q.itemId === item.itemId)) {
                    currentPaper.value.questions.push(item);
                }
            });
            addQuestionDialog.value = false;
        };
        const cancelAdd = () => {
            addQuestionDialog.value = false;
        }

        const handleBankChange = (id) => {
            getBankDetail(id);
        }
    
        const handleSelectionChange = (selection) => {   //从题库添加
            chooseList.value = selection; // 将选中的题目存储到 chooseItem 中
            // console.log(chooseList.value);
        };
        const selectedQuestions = ref([]); // 存储选中的题目
        const handleSelectChange = (select) => {    //试题管理
            selectedQuestions.value = select;
        }
        const batchDeleteDialog = ref(false) //批量删除
        const batchDeleteQuestions = () => {
            ElMessageBox.confirm('确定要删除选中题目吗？', '提示', {
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'warning'
            }).then(() => {
                // console.log(selectedQuestions.value);
                if (selectedQuestions.value.length == 0) {
                    ElMessage.error('未选中题目');
                } else {
                    // 过滤掉选中的题目
                    currentPaper.value.questions = currentPaper.value.questions.filter(question => {
                        return !selectedQuestions.value.some(selected => selected.itemId === question.itemId);
                    });
                    // 清空选中的题目
                    selectedQuestions.value = [];    
                    console.log(currentPaper.value.questions)
                    ElMessage.success('删除成功');
                }
            }).catch(() => {
                // 用户取消操作时的处理，这里可以不做额外操作
            });
        }
        const saveAndPublish = () => {
            const paper = {
                paperInfo: {
                    paperName: currentPaper.value.name,
                    courseId:currentPaper.value.courseId
                },
                items:currentPaper.value.questions.map(question=>question.itemId)
            }
            addPaper(paper).then(res => {
                if (res.data.code === 0) {
                    ElMessage.success('添加试卷成功');
                    resetPaperForm();
                    loadData();
                    addPaperDrawer.value = false;
                } else {
                    ElMessage.error(res.data.message||'添加试卷失败')
                }
            }).catch(error => {
                console.error('添加试卷失败:', error);
                ElMessage.error('添加试卷失败，请稍后重试');
            })
        }

        //保存编辑
        const saveEdit = () => {
            const paper = {
                paperInfo: {
                    paperId:currentPaper.value.id,
                    paperName: currentPaper.value.name,
                    courseId: currentPaper.value.courseId
                },
                items: currentPaper.value.questions.map(question => question.itemId)
            }
            updatePaper(paper).then(res => {
                if (res.data.code === 0) {
                    ElMessage.success('试卷更新成功');
                    resetPaperForm();
                    editPaperDrawer.value = false;
                    loadData();
                } else {
                    ElMessage.error('试卷更新失败');
                }
            }).catch(err => {
                console.error(err);
            })
        }

        const paperList = computed(() => {
            const filteredData = allData.value.filter(paper => {
                return (
                    (!queryInfo.value.paperName || paper.papername.includes(queryInfo.value.paperName)) &&
                    (!queryInfo.value.courseId || paper.courseId === queryInfo.value.courseId)
                );
            });
            const start = (queryInfo.value.pagenum - 1) * queryInfo.value.pagesize;
            const end = start + queryInfo.value.pagesize;
            return filteredData.slice(start, end);
        });

        const resetQuery = () => {
            queryInfo.value = {
                query: '',
                pagenum: 1,
                pagesize: 10,
                total: 0,
                paperName: '',
                courseId: ''
            }
            loadData();
        };

        const printPaper = () => {
            // 打开打印对话框
            setTimeout(() => {
                window.print();
            }, 100); // 短暂延迟确保 DOM 更新完成
        }

        onMounted(() => {
            loadData();
            loadCourseOptions();
            getQuestionBanks();
        });

        return {
            queryInfo,
            allData,
            paperList,
            addPaperDrawer,
            editPaperDrawer,
            drawerTitle,
            activeTab,
            currentPaper,
            viewPaper,
            previewPaperData,
            previewPaper,
            loadData,
            handleSizechange,
            handleCurrentChange,
            handleSelectionChange,
            searchPapers,
            ViewPapers,
            PublishPaper,
            EditPaper,
            DeletePaper,
            handleDrawerClose,
            resetPaperForm,
            courseOptions,
            getQuestionType,
            getAnswer,
            submitAuto,
            addQuestion,
            addQuestionDialog,
            questionBanks,
            selectedBank,
            bankList,
            handleBankChange,
            cancelAdd,
            batchDeleteDialog,
            batchDeleteQuestions,
            handleSelectChange,
            saveAndPublish,
            saveEdit,
            resetQuery,
            printPaper
        };
    }
};
</script>

<style>
.el-input {
    width: 200px;
}
.el-button {
  margin-left: 12px;
}
.el-button {
    margin-left: 12px;
}

.el-card {
    margin-top: 15px;
}
</style>