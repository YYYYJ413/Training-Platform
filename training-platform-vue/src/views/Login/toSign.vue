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
        <div class="sign">
          <div class="loginTitle">欢迎注册账号 <span style="font-family: 华文细黑">:)</span></div>
          <div class="signForm">
            <div class="input userName">
              <div>
                <i class="bi bi-person-fill mr-3"></i>
                <div class="d-inline-block">
                  <div class="mb-1">
                    <small class="text-black-50">姓名/ Name</small>
                  </div>
                  <input type="text" v-model="sign.username" placeholder="用户姓名">
                </div>
              </div>
            </div>
            <div class="input userEmail">
              <div>
                <i class="bi bi-envelope-fill mr-3"></i>
                <div class="d-inline-block">
                  <div class="mb-1">
                    <small class="text-black-50">账号/ Number</small>
                  </div>
                  <input type="email" v-model="sign.usernumber" placeholder="输入账号">
                </div>
              </div>
            </div>
            <div class="input userPassword">
              <div>
                <i class="bi bi-key-fill mr-3"></i>
                <div class="d-inline-block">
                  <div class="mb-1">
                    <small class="text-black-50">密码/ Password</small>
                  </div>
                  <input type="password" v-model="sign.password" placeholder="密码">
                </div>
              </div>
            </div>
            <div class="input userGender">
              <div>
                <i class="bi bi-exclude mr-3"></i>
                <div class="d-inline-block">
                  <div class="mb-1">
                    <small class="text-black-50">性别 / Gender</small>
                  </div>
                  <el-radio v-model="sign.gender" label="0">男性</el-radio>
                  <el-radio v-model="sign.gender" label="1">女性</el-radio>
                </div>
              </div>
            </div>
          </div>
          <div class="mt-4" style="text-align: center">
            <el-button type="warning" round plain @click="router.push('/login')"> 返 回 登 录 </el-button>
            <el-button type="primary" round plain @click="register"> 注 册 账 号 </el-button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import $ from 'jquery'
import { ref,onMounted } from 'vue';
import { ElMessage } from 'element-plus';
import { useRouter } from 'vue-router';
import { RouterName } from '../../enums';
import { signUp } from '../../api';

export default {
  name: "login",
  setup() {
    const sign = ref({
      username: '',
      usernumber: '',
      password: '',
      gender: '1' // 默认值为女性
    });
    const router = useRouter();

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

    const register = async () => {
      // 前端校验
      if (!sign.value.username || !sign.value.usernumber || !sign.value.password) {
        ElMessage.warning('相关注册信息不能为空');
        return;
      }

      try {
        const result = await signUp({
          userNumber: sign.value.usernumber, // 假设账号使用邮箱
          userName: sign.value.username,
          userPassword: sign.value.password,
          userGender: parseInt(sign.value.gender) // 确保发送的是数字
        });

        if (result.data.code===0) {
          ElMessage.success(result.message || '注册成功');
          // 注册成功后的逻辑，例如跳转到登录页面
          router.push(RouterName.Login);
        } else {
          ElMessage.error('注册失败');
        }
      } catch (error) {
        console.error(error);
        ElMessage.error('注册失败，服务器异常');
      }
    };

    onMounted(() => {
      full();
      iconColor();
    })

    return {
      sign,
      register,
      router
    };
  }
};
</script>

<style lang="less">
@import "@/assets/css/login/login.less";
@import "@/assets/css/login/adminLogin.less";

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