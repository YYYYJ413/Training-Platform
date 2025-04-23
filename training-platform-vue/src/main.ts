import { createApp } from 'vue';
import './style.css';
import * as ElementPlusIconsVue from '@element-plus/icons-vue';
import ElementPlus from 'element-plus';
import 'element-plus/dist/index.css';
import App from './App.vue';
import router from './router';
import store from './store';
import { createStore } from 'vuex';

import 'bootstrap/dist/css/bootstrap.min.css';
import 'bootstrap-icons/font/bootstrap-icons.css';


// import { createStore } from 'vuex'; // 修改导入方式

const app = createApp(App);

app.use(ElementPlus);

// 注册所有图标
for (const [key, component] of Object.entries(ElementPlusIconsVue)) {
    app.component(key, component);
}

declare module '@vue/runtime-core' {
    interface State {
        count: number;
    }
    interface ComponentCustomProperties {
        $store: ReturnType<typeof createStore>; // 修改类型定义
    }
}

app.use(ElementPlus);
app.use(router);
app.use(store);
app.mount('#app');