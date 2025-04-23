<template>
    <el-container>
        <!-- 头部 -->
        <el-header>
            <div style="display: flex; margin-right: auto;">
                <img src="@/assets/logo1.png" alt="plat_logo" title="logo">
                <!-- <span>管理系统</span> -->
            </div>
            <!-- <el-button type="info" @click="back">退出</el-button> -->
            <div class="header-right">
                <!-- 下拉菜单 -->
                <el-dropdown trigger="hover" @command="handleCommand">
                    <div class="el-dropdown-link">
                        <el-avatar :size="36" :src="userInfo.avatar" style="margin-right: 8px;"></el-avatar>
                        <span>
                            {{ userInfo.userName }}
                        </span>
                    </div>
                    <template #dropdown>
                        <el-dropdown-menu>
                            <el-dropdown-item @click="back">
                                <i class="bi bi-x-circle"></i>
                                退出登录
                            </el-dropdown-item>
                        </el-dropdown-menu>
                    </template>
                </el-dropdown>
            </div>

        </el-header>
        <!-- 侧边栏 -->
        <el-container>
            <el-aside :width="collapse ? '64px' : '200px'">

                <div class="fold" @click="foldButton">
                    <el-icon class="FOLD_ICON">
                        <Fold v-if="!collapse" />
                        <Expand v-else />
                    </el-icon>
                </div>

                <el-menu background-color="#ffffff" text-color="#000" :collapse="collapse" :collapse-transition="false"
                    router :default-active="isActive" active-text-color="#409EFF" style="text-align: center;">
                    <template v-for="item in menulist" :key="item.id">
                        <el-sub-menu v-if="item.children && item.children.length > 0" :index="item.path">
                            <!-- 模板区域 -->
                            <template #title>
                                <!-- 图标 -->
                                <el-icon>
                                    <component :is="item.icon"></component>
                                </el-icon>
                                <!-- 文字 -->
                                <span>{{ item.authName }}</span>
                            </template>
                            <el-menu-item v-for="child in item.children" :key="child.id" :index="'/' + child.path">
                                <template #title>
                                    <span>{{ child.authName }}</span>
                                </template>
                            </el-menu-item>
                        </el-sub-menu>
                        <el-menu-item v-else :index="item.path" :key="item.id">
                            <el-icon>
                                <component :is="item.icon"></component>
                            </el-icon>
                            <span>{{ item.authName }}</span>
                        </el-menu-item>
                    </template>
                </el-menu>
            </el-aside>
            <el-main :style="{ left: collapse ? '64px' : '200px' }">
                <router-view v-slot="{ Component }">
                    <transition name="fade" mode="out-in">
                        <keep-alive>
                            <component :is="Component" />
                        </keep-alive>
                    </transition>
                </router-view>
            </el-main>
        </el-container>
    </el-container>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue';
import { useStore } from 'vuex';
import { useRouter } from 'vue-router';
import { UserFilled, Search, Promotion, Bell, Moon, HomeFilled, User, Coin, Goods, Memo, Fold, Expand } from '@element-plus/icons-vue';

const store = useStore();
const router = useRouter();

// 定义响应式变量
const collapse = ref(false);
const isActive = ref('');
const menulist = ref([
    {
        id: 0,
        authName: '系统首页',
        path: '/HomePage',
        icon: 'HomeFilled',
    },
    {
        id: 1,
        authName: '用户管理',
        path: '/bg_home/users',
        icon: 'User',
        children: [
            { id: 110, authName: '用户列表', path: 'bg_home/users' },
        ],
    },
    {
        id: 2,
        authName: '考试管理',
        path: '/bg_home',
        icon: 'Bell',
        children: [
            { id: 111, authName: '考试列表', path: 'bg_home/exams' },
        ],
    },
    {
        id: 3,
        authName: '课程管理',
        path: '/bg_home/c',
        icon: 'Notebook',
        children: [
            { id: 104, authName: '课程列表', path: 'bg_home/c' },
        ],
    },
    {
        id: 4,
        authName: '试卷管理',
        path: '/bg_home/papers',
        icon: 'Document',
        children: [
            { id: 107, authName: '试卷列表', path: 'bg_home/papers' },
        ],
    },
    {
        id: 5,
        authName: '题库管理',
        path: '/bg_home/quebank',
        icon: 'Folder',
        children: [
            { id: 8, authName: '题库列表', path: 'bg_home/quebank' },
        ],
    },
    {
        id: 6,
        authName: '提问管理',
        path: '/bg_home/questions',
        icon: 'ChatDotRound',
        children: [
            { id: 126, authName: '提问列表', path: 'bg_home/questions' },
        ],
    },
]);

const defaultAvatar = ref('https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png');
const userInfo = ref({
    userId: store.getters.userId,
    userName: store.getters.userName,
    userNumber: store.getters.userNumber,
    userPassword: store.getters.userPassword,
    contactInfo: store.getters.contactInfo,
    userGender: store.getters.userGender,
    department: store.getters.department || 'null',
    avatar: store.getters.userImg || defaultAvatar.value
});

// 方法
const foldButton = () => {
    collapse.value = !collapse.value;
};

const active = (val) => {
    isActive.value = val;
    window.sessionStorage.setItem('isActive', val);
};

const back = () => {
    store.commit('setToken', false);
    store.commit('setUserId', '');
    store.commit('setUserName', '');
    store.commit('setUserNumber', '');
    store.commit('setUserGender', 1);
    store.commit('setContactInfo', '');
    store.commit('setUserImg', '');
    store.commit('setDepartment', '');
    store.commit('setUserPassword', '');
    localStorage.removeItem('userId');
    localStorage.removeItem('userName');
    localStorage.removeItem('userNumber');
    localStorage.removeItem('userGender');
    localStorage.removeItem('contactInfo');
    localStorage.removeItem('userImg');
    localStorage.removeItem('department');
    localStorage.removeItem('token');
    localStorage.removeItem('userPassword');
    router.push('/Login');
};

const toggleDarkMode = () => {
    const isDark = document.documentElement.classList.toggle('dark');
    localStorage.setItem('darkMode', isDark);
};

const handleCommand = (command) => {
    if (command === 'back') {
        window.sessionStorage.clear();
        router.push('/login');
    }
};

// 生命周期钩子
onMounted(() => {
    isActive.value = window.sessionStorage.getItem('isActive') || '';
    console.log('home:', userInfo.value.avatar);
});
</script>

<style scoped>
.el-container {
    height: 100%;
    width: 100%;
    overflow: hidden;
}

.el-header {
    position: relative;
    display: flex;
    width: 100%;
    padding-left: 0;
    vertical-align: middle;
    justify-content: space-between;
    align-items: center;
    background-color: #ffffff;
    color: #000000;
    font-size: 20px;

    span {
        display: inline-block;
        margin-left: 15px;
    }
}

.el-header img {
    width: 10%;
    margin-left: 10px;
    vertical-align: middle;
}

.fold {
    background-color: #d9effb;
    color: #bab1b1;
    /* font-size: 10px; */
    /* line-height: 24px; */
    /* padding-left: 20px;  */
    transition: padding 0.3s ease;
    text-align: center;
    cursor: pointer;
}

.FOLD_ICON {
    font-size: 24px;
    margin-right: 10px;
}

.flex {
    display: flex;
}

.el-aside {
    background-color: #ffffff;
    position: absolute;
    display: block;
    left: 0;
    top: 60px;
    bottom: 0;
}

.nav-links {
    text-align: left;
    height: 100%;
}

.nav-links ul {
    list-style: none;
    padding: 0;
    margin: 0;
}

.nav-links li {
    list-style: none;
    padding: 20px;
    margin: 0;
}

.el-main {
    background-color: #eaedf1;
    position: absolute;
    left: 200px;
    right: 0;
    top: 60px;
    bottom: 0;
    overflow-y: scroll;
}

.el-dropdown-link {
    color: #000;
    cursor: pointer;
    display: flex;
    flex-direction: row;

    span {
        display: flex;
        align-items: center;
        margin-left: 5px;
        white-space: nowrap;
    }
}

.header-right {
    display: flex;
    float: right;
    padding-right: 50px;
    align-items: center;
    text-align: center;
}


.dark {
    background-color: #1a1a1a;
    color: #f0f0f0;
}

.dark .el-header {
    background-color: #2d2d2d !important;
    color: #f0f0f0 !important;
}

.dark .el-aside {
    background-color: #2d2d2d !important;
}

.dark .el-main {
    background-color: #1a1a1a !important;
}

.dark .el-menu {
    background-color: #2d2d2d !important;
    color: #f0f0f0 !important;
}

.dark .el-dropdown-link {
    color: #f0f0f0 !important;
}
</style>