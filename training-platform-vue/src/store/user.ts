export default {
    state: {
        userName: '',
        userNumber: '',
        userId: '',
        userGender: 1,
        contactInfo: '',
        department:'',
        userImg: '',
        userPassword:''
    },
    getters: {
        // 确保 getters 的名称与 state 中的字段名一致
        userId: (state) => state.userId,
        userName: (state) => state.userName,
        userNumber: (state) => state.userNumber,
        userGender: (state) => state.userGender,
        contactInfo: (state) => state.contactInfo,
        department: (state) => state.department,
        userImg: (state) => state.userImg,
        userPassword:(state)=>state.userPassword
    },
    mutations: {
        // 确保 mutations 的名称与 state 中的字段名一致
        setUserId: (state, userId) => {
            state.userId = userId;
            localStorage.setItem('userId', userId);
        },
        setUserName: (state, userName) => {
            state.userName = userName;
            localStorage.setItem('userName', userName);
        },
        setUserNumber: (state, userNumber) => {
            state.userNumber = userNumber;
            localStorage.setItem('userNumber', userNumber);
        },
        setUserGender: (state, userGender) => {
            state.userGender = userGender;
            localStorage.setItem('userGender', userGender.toString());
        },
        setContactInfo: (state, contactInfo) => {
            state.contactInfo = contactInfo;
            localStorage.setItem('contactInfo', contactInfo);
        },
        setDepartment: (state, department) => {
            state.department = department;
            localStorage.setItem('department', department);
        },
        setUserImg: (state, userImg) => {
            state.userImg = userImg;
            localStorage.setItem('userImg', userImg);
        },
        setUserPassword: (state, password) => {
            state.userPassword = password;
        }
    },
    actions: {
        // 可以在这里定义 actions，用于异步操作
        updateUser({ commit }, user) {
            commit('setUserId', user.userId);
            commit('setUserName', user.userName);
            commit('setUserNumber', user.userNumber);
            commit('setUserGender', user.userGender);
            commit('setContactInfo', user.contactInfo);
            commit('setDepartment',user.department);
            commit('setUserImg', user.userImg);
            commit('setUserPassword', user.userPassword);
        }
    }
};