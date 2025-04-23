<template>
  <div class="container">
    <HeadTabar/>
    <header>
      <div class="header-controls">
        <button class="btn" @click="downloadChat">Export Chat</button>
        <select v-model="selectedModel" @change="checkModel">
          <option v-for="model in modelList" :key="model.name" :value="model.name">
            {{ model.name }} ({{ model.size }})
          </option>
        </select>
        <time>{{ currentTime }}</time>
      </div>
    </header>

    <main>
      <div class="main-container" ref="chatContainer">
        <div v-for="(msg, index) in messages" :key="index" class="message"
             :class="msg.role === 'user' ? 'user-message' : 'ai-message'">
          <div class="message-header">
            <span class="role-tag">{{ msg.role === 'user' ? 'You' : selectedModel }}</span>
            <span class="time-tag">{{ formatTime(msg.createdAt) }}</span>
          </div>
          <div class="message-content">
                        <span v-if="msg.loading" class="loading-dots">
                            <span>.</span><span>.</span><span>.</span>
                        </span>
            <div v-else-if="msg.role === 'assistant'" v-html="renderMarkdown(msg.content)"
                 class="markdown-content"></div>
            <pre v-else>{{ msg.content }}</pre>
          </div>
        </div>
      </div>

      <div class="input-area">
        <input type="text" v-model="userInput" :disabled="isGenerating" @keyup.enter="sendMessage"
               placeholder="请输入您的问题..." />
        <button @click="sendMessage" :disabled="isGenerating || !selectedModel" class="send-button">
          {{ isGenerating ? 'Generating...' : '发送' }}
        </button>
      </div>
    </main>
  </div>
</template>

<script>
import MarkdownIt from 'markdown-it'
import hljs from 'highlight.js'
import DOMPurify from 'dompurify'
import HeadTabar from "../../components/HomeTaber/HeadTabar.vue";

const md = new MarkdownIt({
  html: true,
  linkify: true,
  typographer: true,
  highlight: function (str, lang) {
    if (lang && hljs.getLanguage(lang)) {
      try {
        return hljs.highlight(str, { language: lang }).value
      } catch (__) { }
    }
    return ''
  }
})

export default {
  components: {
    HeadTabar,
  },
  data() {
    return {
      currentTime: '',
      userInput: '',
      messages: [{
        role: 'system',
        content: '你好，我是培训平台智能客服，有什么能够帮助您的?',
        createdAt: Date.now(),
      }],
      modelList: [],
      selectedModel: null,
      isGenerating: false,
      abortController: null,
      maxContextTokens: 4096,
      keepAlive: '5m',
    };
  },
  computed: {
    currentTokens() {
      return this.messages.reduce((sum, msg) =>
          sum + this.approximateTokenCount(msg.content), 0);
    }
  },
  async mounted() {
    this.updateTime();
    this.timer = setInterval(this.updateTime, 1000);
    await this.fetchModels();
    if (this.modelList.length > 0) {
      this.selectedModel = this.modelList[0].name;
    }

    // 添加代码高亮样式
    const link = document.createElement('link')
    link.rel = 'stylesheet'
    link.href = 'https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.5.0/styles/github-dark.min.css'
    document.head.appendChild(link)
  },
  beforeUnmount() {
    clearInterval(this.timer);
    if (this.abortController) {
      this.abortController.abort();
    }
  },
  methods: {
    renderMarkdown(content) {
      const modifiedContent = content
          .replace(/<think>/g, '<div class="think-block">')
          .replace(/<\/think>/g, '</div>');

      const unsafeHtml = md.render(modifiedContent);
      return DOMPurify.sanitize(unsafeHtml, {
        ADD_TAGS: ['think'], // 允许保留 think 标签(虽然已替换成 div)
        ADD_ATTR: ['class']  // 关键修复:允许保留 class 属性
      });
    },

    approximateTokenCount(text) {
      const chineseChars = text.match(/[\u4e00-\u9fa5]/g) || [];
      const otherChars = text.replace(/[\u4e00-\u9fa5]/g, '').length;
      return Math.ceil(chineseChars.length * 1.3 + otherChars * 0.8);
    },

    async fetchModels() {
      try {
        console.log("tags");


        const response = await fetch('http://www.csbio.top:7080/ask/api/tags');
        const data = await response.json();
        this.modelList = data.models.map(m => ({
          name: m.name,
          size: this.formatModelSize(m.size)
        }));
      } catch (error) {
        console.error('Failed to fetch models:', error);
        alert('无法连接大模型,请确保已启动服务');
      }
    },

    async checkModel() {
      try {
        await fetch(`http://www.csbio.top:7080/ask/api/show`, {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({ name: this.selectedModel })
        });
      } catch (error) {
        alert(`模型 ${this.selectedModel} 不可用,请先下载`);
        this.selectedModel = null;
      }
    },

    async sendMessage() {
      if (!this.userInput.trim() || !this.selectedModel || this.isGenerating) return;

      this.messages.push({
        role: 'user',
        content: this.userInput,
        createdAt: Date.now()
      });

      const aiMessage = {
        role: 'assistant',
        content: '',
        createdAt: Date.now(),
        loading: true
      };
      this.messages.push(aiMessage);

      const prompt = this.userInput;
      this.userInput = '';
      this.isGenerating = true;
      this.scrollToBottom();

      try {
        this.abortController = new AbortController();
        const response = await fetch('http://www.csbio.top:7080/ask/api/chat', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({
            model: this.selectedModel,
            messages: this.buildContextMessages(prompt),
            stream: true,
            keep_alive: this.keepAlive,
            options: {
              num_ctx: this.maxContextTokens
            }
          }),
          signal: this.abortController.signal
        });

        const reader = response.body.getReader();
        const decoder = new TextDecoder();

        while (true) {
          const { done, value } = await reader.read();
          if (done) break;

          const chunk = decoder.decode(value);
          const lines = chunk.split('\n').filter(line => line.trim() !== '');

          for (const line of lines) {
            try {
              const parsed = JSON.parse(line);
              aiMessage.content += parsed.message?.content || '';
              aiMessage.loading = false;
              this.$forceUpdate();
              this.scrollToBottom();

              if (parsed.done) {
                this.isGenerating = false;
                this.abortController = null;
              }
            } catch (e) {
              // console.error('解析错误:', e);
            }
          }
        }
      } catch (error) {
        if (error.name !== 'AbortError') {
          console.error('请求失败:', error);
          aiMessage.content = '生成失败: ' + error.message;
          aiMessage.loading = false;
          this.$forceUpdate();
        }
        this.isGenerating = false;
      }
    },

    buildContextMessages(newPrompt) {
      let messages = []; // 初始化消息数组

      // 从最新的消息开始遍历消息数组
      for (let i = this.messages.length - 1; i >= 0; i--) {
        const msg = this.messages[i];
        const content = msg.content;
        // 将消息添加到上下文中
        messages.unshift({
          role: msg.role,
          content: content
        });
      }



      console.log(messages);

      return messages; // 返回构建好的上下文消息数组
    },

    downloadChat() {
      const text = this.messages.map(msg =>
          `${msg.role === 'user' ? '[用户]' : `[${this.selectedModel}]`} ${this.formatTime(msg.createdAt)}\n${msg.content}`
      ).join('\n\n');

      const blob = new Blob([text], { type: 'text/plain' });
      const url = URL.createObjectURL(blob);
      const a = document.createElement('a');
      a.href = url;
      a.download = `microdetect_chat_${new Date().toISOString().slice(0, 10)}.txt`;
      a.click();
      URL.revokeObjectURL(url);
    },

    formatTime(timestamp) {
      return new Date(timestamp).toLocaleTimeString([], {
        hour: '2-digit',
        minute: '2-digit'
      });
    },

    formatModelSize(bytes) {
      const sizes = ['B', 'KB', 'MB', 'GB', 'TB'];
      if (bytes === 0) return '0 B';
      const i = Math.floor(Math.log(bytes) / Math.log(1024));
      return `${(bytes / Math.pow(1024, i)).toFixed(1)} ${sizes[i]}`;
    },

    scrollToBottom() {
      this.$nextTick(() => {
        const container = this.$refs.chatContainer;
        container.scrollTop = container.scrollHeight;
      });
    },

    updateTime() {
      this.currentTime = new Intl.DateTimeFormat('zh-CN', {
        year: 'numeric',
        month: '2-digit',
        day: '2-digit',
        hour: '2-digit',
        minute: '2-digit',
        second: '2-digit',
        hour12: false
      }).format(new Date());
    }
  }
};
</script>

<style scoped>
.container {
  padding: 0 60px;
  background: #ebeef5;
  padding-bottom: 100vh;
}

header {
  text-align: center;
  margin-bottom: 40px;
}

.header-controls {
  padding: 10px;
  display: flex;
  gap: 20px;
  align-items: center;
  justify-content: space-between;
  border-radius: 8px;
}

select {
  padding: 8px 12px;
  border: 2px solid #7eabb6;
  border-radius: 6px;
  background: white;
  color: #363056;
  flex: 1;
  max-width: 300px;
}

time {
  color: #abb2bf;
}

.main-container {
  height: 60vh;
  padding: 20px;
  background: rgba(255, 255, 255, 0.9);
  border-radius: 12px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
  overflow: auto;
  border: #7eabb6 5px solid;
}

.message {
  display: inline-block;
  max-width: 70%;
  word-break: break-word;
  vertical-align: top;
  margin: 10px 0;
  padding: 12px 16px 0;
  transition: transform 0.2s;
}

.user-message {
  background: #e3f2fd;
  float: right;
  clear: both;
  border-radius: 12px 12px 0 12px;
}

.ai-message {
  background: #f5f5f5;
  float: left;
  clear: both;
  border-radius: 12px 12px 12px 0;
}

.message-header {
  display: flex;
  justify-content: space-between;
  margin-bottom: 6px;
  font-size: 0.85em;
}

.role-tag {
  font-weight: bold;
  color: #405c81;
}

.time-tag {
  color: #666;
}

.input-area {
  padding-top: 20px;
  display: flex;
  gap: 10px;
}

input {
  flex: 1;
  padding: 12px 20px;
  border: 2px solid #7eabb6;
  border-radius: 25px;
  outline: none;
  transition: border-color 0.3s;
}

input:focus {
  border-color: #405c81;
}

button {
  padding: 12px 24px;
  border-radius: 25px;
  background: linear-gradient(135deg, #7eabb6, #405c81);
  color: white;
  border: none;
  cursor: pointer;
  transition: opacity 0.3s;
}

button:disabled {
  opacity: 0.7;
  cursor: not-allowed;
}

/* Markdown样式 */
.markdown-content {
  line-height: 1.6;
  font-size: 14px;
}

.markdown-content h1,
.markdown-content h2,
.markdown-content h3 {
  margin: 1em 0 0.5em;
  color: #2c3e50;
}

.markdown-content p {
  margin: 0.8em 0;
}

.markdown-content ul,
.markdown-content ol {
  padding-left: 1.5em;
  margin: 0.8em 0;
}

.markdown-content li {
  margin: 0.4em 0;
}

.markdown-content code {
  background-color: #f3f4f6;
  padding: 2px 4px;
  border-radius: 4px;
  font-family: Menlo, Monaco, Consolas, "Courier New", monospace;
}

.markdown-content pre {
  background-color: #282c34;
  color: #abb2bf;
  padding: 1em;
  border-radius: 8px;
  overflow-x: auto;
  margin: 1em 0;
}

.markdown-content pre code {
  background-color: transparent;
  padding: 0;
}


.markdown-content blockquote {
  border-left: 4px solid #dfe2e5;
  margin: 1em 0;
  padding-left: 1em;
  color: #6a737d;
}

.markdown-content a {
  color: #3eaf7c;
  text-decoration: none;
}

.markdown-content a:hover {
  text-decoration: underline;
}

.loading-dots span {
  animation: dot-pulse 1.4s infinite;
  opacity: 0;
}

.loading-dots span:nth-child(2) {
  animation-delay: 0.2s;
}

.loading-dots span:nth-child(3) {
  animation-delay: 0.4s;
}

@keyframes dot-pulse {

  0%,
  100% {
    opacity: 0.3;
  }

  50% {
    opacity: 1;
  }
}


/* 思考区块 */
.markdown-content ::v-deep .think-block {
  color: #6b7280 !important;
  font-size: 0.9em !important;
  font-style: italic !important;
  background: #f3f4f6 !important;
  border-left: 4px solid #7eabb6 !important;
  padding: 12px !important;
  margin: 12px 0 !important;
  border-radius: 4px !important;
}

/* 处理思考区块内的段落 */
.markdown-content ::v-deep .think-block p {
  margin: 0 !important;
  color: inherit !important;
}

/* 正文段落对比样式 */
.markdown-content ::v-deep p {
  color: #374151;
  margin: 0.8em 0 !important;
}

/* 在文件最底部添加这4行 */
.ai-message,
.user-message,
.markdown-content {
  /* 覆盖Markdown默认样式 */
  font-family: -apple-system, sans-serif !important;
  font-size: 15px !important;
  color: #333 !important;
  line-height: 1.6 !important;
}
</style>