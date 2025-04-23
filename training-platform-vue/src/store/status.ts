export default {
    state: {
        token: false, //是否登录
        bankName: '',
        bankId: '',
        courseId: '',
        chapterId: '',
        examId: '',
        retakeTime:1,
    },
    getters: {
        token: (state) => state.token,
        bankName: (state) => state.bankName,
        courseId: (state) => state.courseId,
        chapterId:(state)=>state.chapterId,
        examId: (state) => state.examId,
        retakeTime:(state)=>state.retakeTime
    },
    mutations: {
        setToken: (state, token) => {
            state.token = token;
        },
        setBankName: (state, bankName) => {
            state.bankName = bankName;
        },
        setCourseId: (state, courseId) => {
            state.courseId = courseId;
        },
        setChapterId: (state, chapterId) => {
            state.chapterId = chapterId;
        },
        setExamId: (state, examId) => {
            state.examId = examId;
        },
        setRetakeTime: (state, retakeTime) => {
            state.retakeTime = retakeTime;
        }
    }
}