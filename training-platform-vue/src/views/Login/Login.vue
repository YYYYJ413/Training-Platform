<template>
    <div class="login">
        <div class="loginCard">
            <div class="cardLeft h-100">
                <a href="/home">
                    <img src="@/assets/img/header/logo1.png" alt="logo" class="logo">
                </a>
                <div style="margin: 0 auto;width: 90%">
                    <img src="@/assets/img/login/loginAside.png" alt="logoAside" class="logoAside">
                </div>
            </div>
            <div class="cardRight h-100">
                <div class="toLogin" style="height: 150px;align-content: flex-end;">
                    <div class="loginTitle">欢迎登陆 <span style="font-family: 华文细黑">:)</span></div>
                    <small class="description text-black-50">
                        请通过电子邮件地址或所绑定的电话号码的信息凭证用密码登录您的个人账户
                        <span><i class="bi bi-bell-fill"></i></span>
                    </small>
                    <!-- 
                    <div class="loginInput">
                        <router-view></router-view>
                    </div> -->
                </div>
                <!-- 添加外层翻转容器 -->
                <div class="flip-container" :class="{ 'flipped': isFlipped }">
                    <div class="flipper">
                        <!-- 原有管理员登录卡片 -->
                        <div class="adminLogin front mt-5">
                            <div class="inputGroup">
                                <div class="input admin">
                                    <div>
                                        <i class="bi bi-person-gear mr-3"></i>
                                        <div class="d-inline-block">
                                            <div class="mb-1">
                                                <small class="text-black-50">管理员账户/Admin Account</small>
                                            </div>
                                            <input type="text" v-model="adminForm.account" placeholder="管理员账号"
                                                @keyup.enter="adminLogin">
                                        </div>
                                    </div>
                                </div>
                                <div class="input password">
                                    <div>
                                        <i class="bi bi-shield-lock-fill mr-3"></i>
                                        <div class="d-inline-block">
                                            <div class="mb-1">
                                                <small class="text-black-50">管理员密码/Password</small>
                                            </div>
                                            <input type="password" v-model="adminForm.password" placeholder="密码"
                                                @keyup.enter="adminLogin">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="toSubmit mt-3" style="text-align: center;">
                                <el-button round type="danger" @click="adminLogin" style="width: 35%;">
                                    登录
                                </el-button>
                                <div class="p-2" />
                                <el-button type="primary" round plain @click="toggleFlip">
                                    用户登录
                                </el-button>
                            </div>
                        </div>

                        <!-- 新增用户登录背面卡片 -->
                        <div class="userLogin back mt-5">
                            <!-- 这里放置你的用户登录组件内容 -->
                            <div class="inputGroup">
                                <div class="input user">
                                    <div class="tubiao">
                                        <i class="bi bi-person-circle mr-3"></i>
                                        <div class="d-inline-block">
                                            <div class="mb-1">
                                                <small class="text-black-50">用户信息/ Account</small>
                                            </div>
                                            <input type="text" v-model="userForm.userNumber" placeholder="用户账号"
                                                @keyup.enter="userLogin">
                                        </div>
                                    </div>
                                </div>
                                <div class="input password">
                                    <div class="tubiao">
                                        <i class="bi bi-shield-lock-fill mr-3"></i>
                                        <div class="d-inline-block">
                                            <div class="mb-1">
                                                <small class="text-black-50">用户密码/ Password</small>
                                            </div>
                                            <input type="password" v-model="userForm.password" placeholder="密码"
                                                @keyup.enter="userLogin">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="toSubmit mt-3" style="text-align: center;">
                                <el-button round type="warning" @click="userLogin" @keyup.enter="userLogin"
                                    style="width: 35%;"> 登 录
                                </el-button>
                                <el-button type="primary" round plain @click="router.push('/signup')">用 户 注
                                    册</el-button>
                                <!-- //增加管理员登录按钮  -->
                                <p />

                                <el-button type="danger" round plain @click="toggleFlip">
                                    管理员登录
                                </el-button>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script lang="ts">
import $ from 'jquery'
import { ElMessage } from 'element-plus'
import { RouterName } from '../../enums'
import { useRouter } from 'vue-router'
import { getCurrentInstance, ref } from 'vue'
import { signIn } from '../../api'
import { useStore } from 'vuex'

export default {
    name: "login",
    setup() {
        const router = useRouter();
        const store = useStore();
        const { proxy } = getCurrentInstance();
        const isFlipped = ref(false);
        const adminForm = ref({
            account: '',
            password: ''
        });
        const userForm = ref({
            userNumber: '',
            password: ''
        });

        const full = () => {
            // 登录区域全屏高度
            $(".login").css({
                height: "100vh"
            });
        };

        const iconColor = () => {
            // 给输入框添加焦点和失去焦点的事件，当焦点在输入框上时，给图标添加颜色，当焦点不在输入框上时，移除图标颜色
            $(".input input").on("focus", function () {
                $(this).parent().siblings(".bi").addClass("adiconColor");
            }).on("blur", function () {
                $(this).parent().siblings(".bi").removeClass("adiconColor")
            });
        };

        const adminLogin = async () => {
            const usernumber = adminForm.value.account.trim(); // 去除首尾空格
            const password = adminForm.value.password.trim(); // 去除首尾空格
            const typeId = 1111;

            if (!usernumber || !password) {
                ElMessage.error('账号或密码不能为空');
                return;
            }
            try {
                const result = await signIn({ usernumber, password, typeId });

                if (result.data.code === 0) {
                    const data = result.data.data;
                    proxy.$store.commit("setUserId", data.userId);
                    proxy.$store.commit("setUserName", data.userName);
                    proxy.$store.commit("setUserNumber", data.userNumber);
                    proxy.$store.commit('setUserGender', data.userGender);
                    proxy.$store.commit('setContactInfo', data.contactInfo);
                    proxy.$store.commit('setUserImg', data.userImg);
                    proxy.$store.commit('setDepartment', data.department);
                    proxy.$store.commit('setToken', true);
                    proxy.$store.commit('setUserPassword', data.userPassword);
                    ElMessage.success('登录成功');
                    router.push(RouterName.bgHome);
                } else {
                    console.log(result);
                    ElMessage.error('账号或密码错误');
                }
            } catch (error) {
                console.error('登录失败:', error);
            }
        };

        const userLogin = async () => {
            const typeId = 1000;
            const usernumber = userForm.value.userNumber.trim(); // 去除首尾空格
            const password = userForm.value.password.trim(); // 去除首尾空格
            if (!usernumber|| !password) {
                ElMessage.error('账号或密码不能为空');
                return;
            }
            try {
                const result = await signIn({ usernumber, password, typeId });
                if (result.data.code === 0) {  
                    const data = result.data.data;
                    proxy.$store.commit("setUserId", data.userId);
                    proxy.$store.commit("setUserName", data.userName);
                    proxy.$store.commit("setUserNumber", data.userNumber);
                    proxy.$store.commit('setUserGender', data.userGender);
                    proxy.$store.commit('setContactInfo', data.contactInfo);
                    proxy.$store.commit('setUserImg', data.userImg);
                    proxy.$store.commit('setDepartment', data.department);
                    proxy.$store.commit('setToken', true);
                    proxy.$store.commit('setUserPassword', data.userPassword);
                    ElMessage.success('登录成功');
                    router.push(RouterName.Home);
                } else {
                    console.log(result)
                    ElMessage.error('账号或密码错误');
                }
            } catch (error) {
                console.error('登录失败:', error);
            }
        };

        const toggleFlip = () => {
            isFlipped.value = !isFlipped.value;
            // 切换时清除另一面的数据
            if (isFlipped.value) {
                adminForm.value = { account: '', password: '' };
            } else {
                userForm.value = { userNumber: '', password: '' };
            }
        };

        return {
            adminForm,
            userForm,
            isFlipped,
            full,
            iconColor,
            adminLogin,
            userLogin,
            toggleFlip,
            router
        };
    },
    mounted() {
        this.full(); // 初始化时设置容器高度
        this.iconColor();
    }
};
</script>

<style lang="less">
@import "../../assets/css/login/login.less";
@import "../../assets/css/login/adminLogin.less";

.loginCard {
    width: 1000px;
    height: 600px;
    transform-origin: 0 0;
    box-sizing: border-box;
    flex-shrink: 0;
    display: flex;
    align-items: stretch;
}


/* 添加翻转动画样式 */
.flip-container {
    perspective: 1000px;

    .flipper {
        transition: 0.6s;
        transform-style: preserve-3d;
        position: relative;
    }

    &.flipped .flipper {
        transform: rotateY(180deg);
    }
}

.front,
.back {
    backface-visibility: hidden;
    position: absolute;
    width: 100%;
}

.back {
    transform: rotateY(180deg);
}
</style>