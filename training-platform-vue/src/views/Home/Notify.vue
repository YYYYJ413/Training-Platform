<template>
  <div class="notify">
    <head-tabar></head-tabar>

    <div class="notify-container">

      <div class="notify-header">
        <h2>消息中心</h2>
        <el-button type="primary" @click="markTabAsRead(activeTab)" class="mark-all-btn">
          全部标记为已读
          <el-badge v-if="unreadCount(activeTab) > 0" :value="unreadCount(activeTab)" class="badge"></el-badge>
        </el-button>
      </div>

      <el-tabs v-model="activeTab" class="notify-tabs">
        <el-tab-pane name="system">
          <template #label>
            <!-- 插槽 -->
            <span>系统消息 <el-badge :value="unreadCount('system')" :max="99" class="tab-badge"></el-badge></span>
          </template>
          <transition-group name="list" tag="div" class="message-list">
            <div
                v-for="(msg, index) in systemMessages"
                :key="msg.id"
                class="message-item"
                :class="{ 'unread': !msg.read }"
            >
              <div class="message-content">
                <i class="bi bi-info-circle" v-if="msg.type === 'info'"></i>
                <i class="bi bi-exclamation-triangle" v-if="msg.type === 'warning'"></i>
                <span>{{ msg.content }}</span>
              </div>
              <div class="message-time">{{ msg.time }}</div>
            </div>
          </transition-group>
        </el-tab-pane>

        <el-tab-pane name="interaction">
          <template #label>
            <span>互动消息 <el-badge :value="unreadCount('interaction')" :max="99" class="tab-badge"></el-badge></span>
          </template>
          <transition-group name="list" tag="div" class="message-list">
            <div
                v-for="(msg, index) in interactionMessages"
                :key="msg.id"
                class="message-item"
                :class="{ 'unread': !msg.read }"
            >
              <div class="message-content">
                <i class="bi bi-chat-left-text" v-if="msg.type === 'comment'"></i>
                <i class="bi bi-heart" v-if="msg.type === 'like'"></i>
                <span>{{ msg.content }}</span>
              </div>
              <div class="message-time">{{ msg.time }}</div>
            </div>
          </transition-group>
        </el-tab-pane>

      </el-tabs>
    </div>
  </div>

</template>

<script>
import HeadTabar from "../../components/HomeTaber/HeadTabar.vue";

export default {
  components: {
    HeadTabar
  },
  name: 'Notify',
  data() {
    return {
      activeTab: 'system',
      systemMessages: [
        { id: 1, content: '系统将于今晚23:00进行维护升级', type: 'info', time: '2025-04-09 10:30', read: false },
        { id: 2, content: '系统更新完成，新增了多项功能', type: 'info', time: '2025-04-10 09:00', read: true },
      ],
      interactionMessages: []
    }
  },
  methods: {
    markTabAsRead(tabName) {
      if (tabName === 'system') {
        this.systemMessages.forEach(msg => msg.read = true);
      } else {
        this.interactionMessages.forEach(msg => msg.read = true);
      }
      this.$message.success(`${tabName === 'system' ? '系统' : '互动'}消息已全部标记为已读`);
    },
    unreadCount(tabName) {
      if (tabName === 'system') {
        return this.systemMessages.filter(msg => !msg.read).length;
      } else {
        return this.interactionMessages.filter(msg => !msg.read).length;
      }
    },
    addInteractionMessage(content) {
      const newMessage = {
        id: this.interactionMessages.length + 1,
        content: content,
        type: 'comment',
        time: new Date().toLocaleString(),
        read: false
      };
      this.interactionMessages.push(newMessage);
      console.log('New message added:', newMessage);
    },
    handleNewReplyFromStorage() {
      const message = localStorage.getItem('newReplyMessage');
      if (message) {
        this.addInteractionMessage(message);
        localStorage.removeItem('newReplyMessage'); // 清除消息
      }
    }
  },
  mounted() {
    // 监听 localStorage 的变化
    window.addEventListener('storage', this.handleNewReplyFromStorage);

    // 也可以在组件加载时检查是否有未读消息
    const message = localStorage.getItem('newReplyMessage');
    if (message) {
      this.addInteractionMessage(message);
      localStorage.removeItem('newReplyMessage'); // 清除消息
    }
  },

  beforeUnmount() {
    window.removeEventListener('storage', this.handleNewReplyFromStorage);
  }

}

</script>


<style scoped>
.notify-container {
  padding: 20px;
  max-width: 800px;
  margin: 80px auto 0;
}

.notify-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}

.notify-tabs {
  background: #fff;
  padding: 20px;
  border-radius: 4px;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
}

.message-list {
  margin-top: 15px;
}

.message-item {
  padding: 15px;
  border-bottom: 1px solid #ebeef5;
  display: flex;
  justify-content: space-between;
  align-items: center;
  transition: all 0.3s;
}

.message-item.unread {
  background-color: #f5f7fa;
}

.message-content {
  display: flex;
  align-items: center;
}

.message-content i {
  margin-right: 10px;
  font-size: 18px;
}

.message-time {
  color: #909399;
  font-size: 12px;
}

/* 动画效果 */
.list-enter-active, .list-leave-active {
  transition: all 0.5s;
}
.list-enter, .list-leave-to {
  opacity: 0;
  transform: translateX(30px);
}
.badge {
  margin-left: 8px;
}
.tab-badge {
  margin-left: 8px;
}
</style>




