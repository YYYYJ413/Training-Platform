import axios from './request';

// 登录验证
export const signIn = ({ usernumber, password, typeId }) => {
    return axios.post(`/user/login/number`, { usernumber, password, typeId });
};

// 注册
export const signUp = ({ userNumber, userName, userPassword, userGender }) => {
    return axios.post(`/user/register`, { userNumber, userName, userPassword, userGender });
};
//获取用户信息
export const getUserById = (id) => {
    return axios.get(`/bg/users/${id}`);
}
//获取指定考试信息
export const getExamById = (examId) => {
    return axios.get(`/exam/${examId}`);
}
//考试列表（后台）
export const getExamList = () => {
    return axios.get(`/exam/list`);
};
//删除考试
export const deleteExam = (examId) => {
    return axios.delete(`/exam/delete/${examId}`);
}
//添加/更新考试
export const updateExam = (exam) => {
    return axios.post(`/exam/update`, exam);
}
//获取我的考试
export const getMyExam = (userId) => {
    return axios.get(`/exam/mylist/${userId}`);
}
//获取考试考生情况
export const getUserOfExam = (examId) => {
    return axios.get(`examinfo/userOfExam/${examId}`);
}

//试卷列表
export const getPaperList = () => {
    return axios.get(`/paper/all`);
};
//试卷信息
export const getPaperInfo = (paperId) => {
    return axios.get(`/paper/detail/${paperId}`);
}
//试卷详细信息（含题目选项）
export const getPaperDetail = (paperId) => {
    return axios.get(`/paper/itemDetail/${paperId}`);
}
//添加试卷（手动）
export const addPaper = (paper) => {
    return axios.post(`/paper/add`, paper);
}
//自动组卷
export const autoMaticPaper = (rule, courseId) => {
    return axios.post(`/paper/${courseId}/automatic`, rule);
}
//删除试卷
export const deletePaper = (paperId) => {
    return axios.delete(`/paper/delete/${paperId}`);
}
//更新试卷
export const updatePaper = (paper) => {
    console.log(paper);
    return axios.post(`/paper/update`, paper);
}

//课程列表
export const getCourseList = () => {
    return axios.get(`/course/showAll`);
}
//添加课程
export const addCourse = (courseName, courseCover, courseDescription, courseType, courseTeacher) => {
    return axios.post(`/course/new?courseName=${courseName}&courseCover=${courseCover}
        &courseDescription=${courseDescription}&courseType=${courseType}&courseTeacher=${courseTeacher}`);
}
//添加章节
export const submitSections = (sections) => {
    return axios.post(`/section/submitSections`, sections);
}

// 提交考试答案
export const submitExam = (userId, examId, retake, itemId, optionId, answer) => {
    return axios.post(`/uexam/add?examId=${examId}&userId=${userId}&retake=${retake}&itemId=${itemId}&optionId=${optionId}&answer=${answer}`);
}
//已考次数
export const getMaxRetakes = (userId, examId) => {
    return axios.get(`/examinfo/maxRetakes?userId=${userId}&examId=${examId}`);
}
//剩余重考次数
export const fetchRemaingingTakeTime = (userId, examId) => {
    return axios.get(`examinfo/remainingRetakes?examId=${examId}&userId=${userId}`);
}

//获取我的课程
export const getMyCourse = (userId) => {
    // console.log(userId);
    return axios.get(`/course/show/${userId}`);
}
//获取指定课程章节进度
export const getProgress = (userId, courseId, chapterId)=>{
    return axios.get(`/progress/get?userId=${userId}&courseId=${courseId}&chapterId=${chapterId}`);
}
//更新进度
export const updateProgress = (progress) => {
    return axios.post(`/progress/update`, progress);
}
//获取指定课程
export const findCourse = (courseId) => {
    return axios.get(`/course/find`, {
        params: {
            courseId: courseId
        }
    })
}
//获取所有课程
export const getAllCourse = () => {
    return axios.get(`/course/showAll`);
}
//课程章节数
export const getchapterData = (courseId) => {
    return axios.get(`/section/show?courseId=${courseId}`);
}
//课程学习人数
export const getSubscriberCount = (courseId) => {
    return axios.get(`/ucourse/count/${courseId}`);
}
//选择课程
export const choose = (userId, courseId) => {
    return axios.post(`/course/choose?userId=${userId}&courseId=${courseId}`);
}

//题库列表
export const getBankList = () => {
    return axios.get(`/bank/all`);
}
//添加题库
export const addBank = (bank) => {
    return axios.post(`/bank/add`, bank);
}
//删除题库
export const deleteBank = (id) => {
    return axios.delete(`/bank/delete/${id}`);
}
//编辑题库信息（不包括题目）
export const updateBank = (bank) => {
    return axios.put(`/bank/update`, bank);
}

//获取题库题目信息
export const getBankQueList = (id) => {
    return axios.get(`/item-bank/getList/${id}`);
}
//新建题目
export const addItemBank = (item) => {
    return axios.post(`/item-bank/add`, item);
}
//更新题目
export const updateItemBank = (item) => {
    return axios.post(`/item-bank/update`, item);
}
//删除题目
export const deleteItemBank = (itemId) => {
    return axios.delete(`/item-bank/delete/${itemId}`);
}
