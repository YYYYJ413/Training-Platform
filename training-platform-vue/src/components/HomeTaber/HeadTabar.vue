<template>
  <div id="head-tabar">
    <!-- 顶部导航栏 -->
    <div
      style="display: flex; align-items: center; justify-content: space-between; padding: 0 5%; height: 100%;margin-left: 100px;">
      <!-- 学校名 -->
      <img :src="imgurl" alt="logo" style="height: 50px; width: auto;cursor:pointer" v-if="imgurl"
        @click="$router.push('/')">
      <!-- <h3 style="font-size: 150%; font-family:monospace; color: #000000;">{{ school }}</h3> -->

      <!-- 菜单和搜索框 -->
      <div style="display: flex; align-items: center;width: 500px;">
        <el-menu mode="horizontal" style="border-bottom: none;width: 100%;" :default-active="$route.path" router>
          <el-menu-item index="/course">
            <i class="bi bi-book"></i>
            <span slot="title">&nbsp;课程中心</span>
          </el-menu-item>
          <el-menu-item index="/studycenter/1">
            <i class="bi bi-mortarboard"></i>
            <span slot="title">&nbsp;学习中心</span>
          </el-menu-item>
          <el-menu-item index="/notify">
            <i class="bi bi-bell"></i>
            <span slot="title">&nbsp;通知</span>
          </el-menu-item>
          <el-menu-item index="/ai">
            <i class="bi bi-headset"></i>
            <span slot="title">&nbsp;客服</span>
          </el-menu-item>

        </el-menu>
      </div>

      <!-- 登录/注册按钮 -->
      <div v-if="!token">
        <el-button link type="primary" @click="toLogin">登录/注册</el-button>
      </div>

      <!-- 已登录状态 -->
      <div v-else style="display: flex; align-items: center;">
        <el-dropdown>
          <span class="el-dropdown-link" style="cursor: pointer; display: flex; align-items: center;">
            <el-avatar :size="36"
              :src="headImg || 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png'"
              style="margin-right: 8px;" />
            <span style="display: flex; align-items: center;">
              {{ name }}
            </span>
          </span>
          <template #dropdown>
            <el-dropdown-menu>
              <el-dropdown-item @click="toUserInfo">
                <i class="bi bi-people"></i>
                个人资料</el-dropdown-item>
              <el-dropdown-item @click="loginout">
                <i class="bi bi-x-circle"></i>
                退出登录</el-dropdown-item>
            </el-dropdown-menu>
          </template>
        </el-dropdown>
      </div>
    </div>
  </div>
</template>

<script>
import { computed,getCurrentInstance,onMounted,ref } from 'vue';
import { useStore } from 'vuex';
import { useRouter } from 'vue-router';
import { ElMessage } from 'element-plus';
import router from '@/router'; // 假设你有一个路由名称常量

export default {
  name: "HeadTabar",
  setup() {
    const store = useStore();
    const { proxy } = getCurrentInstance();
    const router = useRouter();
    const imgurl = ref(new URL('../../assets/logo1.png', import.meta.url).href);
    const searchText = ref('');
    const token = computed(() => store.getters.token);
    const name = computed(() => store.getters.userName);
    const headImg = computed(() => store.getters.userImg);

    const toLogin = () => {
      router.push('/Login');
    };

    const toUserInfo = () => {
      router.push('/studycenter/4');
    };

    const loginout = () => {
      proxy.$store.commit("setToken", false);
      proxy.$store.commit("setUserId", '');
      proxy.$store.commit("setUserName", '');
      proxy.$store.commit("setUserNumber", '');
      proxy.$store.commit('setUserGender', 1); // 默认值为1，您可以根据需要调整
      proxy.$store.commit('setContactInfo', '');
      proxy.$store.commit('setUserImg', '');
      proxy.$store.commit('setDepartment', '');
      proxy.$store.commit('setUserPassword', '');
      localStorage.removeItem('userId');
      localStorage.removeItem('userName');
      localStorage.removeItem('userNumber');
      localStorage.removeItem('userGender');
      localStorage.removeItem('contactInfo');
      localStorage.removeItem('userImg');
      localStorage.removeItem('department');
      localStorage.removeItem('token');
      localStorage.removeItem('userPassword');
      router.push('/');
    };

    const extractColorByName = (name) => {
      var temp = ['#'];
      for (let index = 0; index < name.length; index++) {
        temp.push(parseInt(name[index].charCodeAt(0), 10).toString(16));
      }
      return temp.slice(0, 5).join('').slice(0, 4);
    };

    onMounted(() => {
      // console.log(store.getters.token)
    })

    return {
      imgurl,
      searchText,
      token,
      name,
      headImg,
      toLogin,
      toUserInfo,
      loginout,
      extractColorByName
    };
  }
};
</script>

<style scoped>
#head-tabar {
  background: #ffffff;
  /*background-image: url("../assets/headbar.jpg");*/
  /*background-size: 100% 100%;*/
  width: 100%;
  height: 70px;
  position: fixed;
  top: 0;
  left: 0;
  z-index: 1000;
  
  
}

</style>
