<template>
    <el-container>
        <!-- 头部 -->
        <el-header>
            <div>
                <img src="../../assets/manage.png">
                <span>管理系统</span>
            </div>
            <!-- <el-button type="info" @click="back">退出</el-button> -->
            <div class="header-right">
                <el-avatar src="https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png">
                    <!-- <el-icon>
                        <UserFilled/>
                    </el-icon> -->
                </el-avatar>
                <!-- 下拉菜单 -->
                <el-dropdown trigger="hover" @command="handleCommand">
                    <span class="el-dropdown-link">
                        {{this.username}}
                    </span>
                    <template #dropdown>
                        <el-dropdown-menu>
                            <el-dropdown-item>
                                个人中心
                            </el-dropdown-item>
                            <el-dropdown-item command="back">
                                退出登录
                            </el-dropdown-item>
                        </el-dropdown-menu>
                    </template>
                </el-dropdown>
            </div>
            <!-- 用户头像 -->

        </el-header>
        <!-- 侧边栏 -->
        <el-container>
            <el-aside :width="collapse? '64px':'200px'">
                <div class="fold" @click="foldButton">|||</div>
                <el-menu background-color="#4d5257" text-color="#fff" :collapse="collapse" :collapse-transition="false"
                    router :default-active="isActive" active-text-color="#409EFF">
                    <template v-for="item in menulist" :key="item.id">
                        <el-sub-menu v-if="item.children && item.children.length>0" :index="item.path">
                            <!-- 模板区域 -->
                            <template #title>
                                <!-- 图标 -->
                                <el-icon>
                                    <component :is="item.icon"></component>
                                </el-icon>
                                <!-- 文字 -->
                                <span>{{ item.authName }}</span>
                            </template>
                            <el-menu-item v-for="child in item.children" :key="child.id" :index="'/'+child.path">
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
                <router-view v-slot="{Component}">
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

<script>
import { UserFilled } from '@element-plus/icons-vue';
import imgurl from '../../assets/user.png';

export default {
    data() {
        return {
            username: '',
            // 左侧菜单栏数据
            menulist: [
                {
                    id: 0,
                    authName: '系统首页',
                    path: '/homePage',
                    icon: 'HomeFilled',
                },
                {
                    id: 125,
                    authName: '用户管理',
                    path: '/home/users',
                    icon:'User',
                    children: [
                        { id: 110, authName: '用户列表', path: 'users' }
                    ]
                },
                {
                    id: 103,
                    authName: '权限管理',
                    path: '/home/rights',
                    icon:'Coin',
                    children: [
                        { id: 111, authName: '角色列表', path: 'roles' },
                        // { id: 112, authName: '权限列表', path: 'rights' }
                    ]
                },
                {
                    id: 101,
                    authName: '商品管理',
                    path: '/home/goods',
                    icon:'Goods',
                    children: [
                        { id: 104, authName: '商品列表', path: 'goods' },
                        { id: 115, authName: '分类参数', path: 'params' },
                        { id: 121, authName: '商品分类', path: 'cate' }
                    ]
                },
                {
                    id: 102,
                    authName: '资源管理',
                    path: '/home/course',
                    icon:'Memo',
                    children: [
                        { id: 107, authName: '课程管理', path: 'course' }
                    ]
                },
                {
                    id: 145,
                    authName: '数据统计',
                    icon: 'Coin',
                    path: '/home/reports',
                    children: [
                        { id: 126, authName: '数据报表', path: 'reports' }
                    ]
                }
            ],
            // 左侧菜单栏图标
            iconObj: {
                '125': 'iconfont icon-users',
                '103': 'iconfont icon-tijikongjian',
                '101': 'iconfont icon-shangpin',
                '102': 'iconfont icon-danju',
                '145': 'iconfont icon-baobiao',
            },
            // 是否折叠
            collapse: false,
            // 图标高亮
            isActive: '',
        }
    },
    created() {
        // 获取图标高亮数据
        this.isActive = window.sessionStorage.getItem('isActive') || '';
        // console.log('isActive:', this.isActive); 
    },
    mounted() {
        this.username = window.sessionStorage.getItem('username')
        // console.log('home:'+this.username)
    },
    methods: {
        foldButton() {
            this.collapse = !this.collapse
        },
        active(val) {
            this.isActive = val;
            // 将数据存到本地
            window.sessionStorage.setItem('isActive', val);
        },
        back() {
            
        },
        handleCommand(command) {
            if (command == 'back') {
                window.sessionStorage.clear()
                this.$router.push('/login') 
            }
        }
    },
    activated() {
        console.log('home activated')
    }
}
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
    background-color: #4d5257;
    color: #fff;
    font-size: 20px;
    span {
        display: inline-block;
        margin-left: 15px;
    }
}

.el-header img {
    width: 20%;
    margin-left: 10px;
    vertical-align: middle;
}

.fold {
    background-color: #3b5371;
    color: #fff;
    font-size: 10px;
    line-height: 24px;
    text-align: center;
    cursor: pointer;
}

.flex{
    display: flex;
}
.el-aside{
    background-color: #4d5257;
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
.el-main{
    background-color: #eaedf1;
    position: absolute;
    left: 200px;
    right: 0;
    top:60px;
    bottom: 0;
    overflow-y: scroll;
}

.el-dropdown-link{
    color: #fff;
    cursor: pointer;
    display: flex;
    align-items: center;
}
.header-right{
    display: flex;
    float:right;
    padding-right: 50px;
    align-items:center;
    text-align: center;
}
</style>