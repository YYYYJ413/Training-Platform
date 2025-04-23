<template>
  <div class="user-list" style="padding: 15px">
    <el-breadcrumb>
      <el-breadcrumb-item :to="{ path: '/HomePage' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>用户管理</el-breadcrumb-item>
      <el-breadcrumb-item>用户列表</el-breadcrumb-item>
    </el-breadcrumb>
    <el-card style="width: 100%;" shadow="hover">
      <el-row :gutter="20">
        <el-col :span="7">
          <div style="display: flex;">
            <el-input v-model="searchQuery" placeholder="请输入内容">
              <template #append>
                <el-button @click="handleSearch">
                  <el-icon>
                    <Search />
                  </el-icon>
                </el-button>
              </template>
            </el-input>
          </div>
        </el-col>
        <el-col :span="4">
          <el-button type="primary" @click="addUserDialog = true">添加用户</el-button>
        </el-col>
      </el-row>

      <el-row :gutter="20">
        <el-col :span="24">
          <div style="height: 30px;"></div>
        </el-col>
      </el-row>

      <el-table :data="paginatedUsers" style="width:100%" border @selection-change="handleSelectionChange">
        <el-table-column type="index"></el-table-column>
        <el-table-column label="姓名" prop="username"></el-table-column>
        <el-table-column label="账号" prop="userNumber"></el-table-column>
        <el-table-column label="电话" prop="mobile"></el-table-column>
        <el-table-column label="密码" prop="password"></el-table-column>
        <el-table-column label="部门" prop="department"></el-table-column>
        <el-table-column label="性别" prop="genderDisplay"></el-table-column>
        <el-table-column label="头像">
          <template #default="scope">
            <el-image :src="scope.row.avatar || defaultAvatar" style="width: 50px; height: 50px"></el-image>
          </template>
        </el-table-column>
        <el-table-column label="创建时间" prop="create_time" width="110px"></el-table-column>
        <el-table-column label="修改时间" prop="update_time" width="110px"></el-table-column>
        <el-table-column label="角色" prop="roleDisplay"></el-table-column>
        <el-table-column label="操作" width="130px" align="center">
          <template #default="scope">
            <el-button type="primary" @click="edit(scope.row.id)">
              <el-icon>
                <Edit />
              </el-icon>
            </el-button>
            <el-button type="danger" @click="deleteUser(scope.row.id)">
              <el-icon>
                <Delete />
              </el-icon>
            </el-button>
          </template>
        </el-table-column>
      </el-table>

      <!-- 分页 -->
      <el-pagination @current-change="handleCurrentChange" @size-change="handleSizeChange"
                     :current-page="page.pagenum" :page-sizes="[5, 10, 20, 50, 100]" :page-size="page.pagesize"
                     layout="total,sizes,prev,pager,next,jumper" :total="filteredUsers.length" style="float: right; margin: 15px;">
      </el-pagination>

      <!-- 添加用户 -->
      <el-dialog title="添加用户" width="40%" v-model="addUserDialog">
        <el-form :model="addForm" :rules="ruleForm" ref="formRef" label-width="70px">
          <el-form-item label="用户名" prop="username">
            <el-input v-model="addForm.username"></el-input>
          </el-form-item>
          <el-form-item label="账号" prop="userNumber">
            <el-input v-model="addForm.userNumber"></el-input>
          </el-form-item>
          <el-form-item label="密码" prop="password">
            <el-input v-model="addForm.password" show-password></el-input>
          </el-form-item>
          <el-form-item label="手机" prop="mobile">
            <el-input v-model="addForm.mobile"></el-input>
          </el-form-item>
          <el-form-item label="部门" prop="department">
            <el-input v-model="addForm.department" placeholder="请输入部门名称"></el-input>
          </el-form-item>
          <el-form-item label="性别" prop="gender">
            <el-radio-group v-model="addForm.gender">
              <el-radio :value="0">男</el-radio>
              <el-radio :value="1">女</el-radio>
            </el-radio-group>
          </el-form-item>
          <el-form-item label="头像">
            <el-upload
                class="upload-demo"
                drag
                action="http://localhost:3000/upload"
                :on-success="handleAvatarSuccess"
                :on-error="handleAvatarError"
                :show-file-list="false"
                :auto-upload="true">
              <i class="el-icon-upload"></i>
              <div class="el-upload__text">将文件拖到此处，或<em>点击上传</em></div>
              <div class="el-upload__tip" slot="tip" type="success">只能上传 JPG/PNG 文件，且不超过 2MB</div>
            </el-upload>
          </el-form-item>
        </el-form>

        <template #footer>
          <span class="dialog-footer">
            <el-button @click="addUserDialog = false">取 消</el-button>
            <el-button type="primary" @click="userAdd">确 定</el-button>
          </span>
        </template>
      </el-dialog>

      <!-- 编辑用户 -->
      <el-dialog title="编辑用户" width="40%" v-model="editaddUserDialog">
        <el-form :model="editForm" :rules="ruleForm" ref="editFormRef" label-width="70px">
          <el-form-item label="用户名" prop="username">
            <el-input v-model="editForm.username"></el-input>
          </el-form-item>
          <el-form-item label="账号" prop="userNumber">
            <el-input v-model="editForm.userNumber"></el-input>
          </el-form-item>
          <el-form-item label="密码" prop="password">
            <el-input v-model="editForm.password" show-password></el-input>
          </el-form-item>
          <el-form-item label="手机" prop="mobile">
            <el-input v-model="editForm.mobile"></el-input>
          </el-form-item>
          <el-form-item label="部门" prop="department">
            <el-input v-model="editForm.department" placeholder="请输入部门名称"></el-input>
          </el-form-item>
          <el-form-item label="性别" prop="gender">
            <el-radio-group v-model="editForm.gender">
              <el-radio :value="0">男</el-radio>
              <el-radio :value="1">女</el-radio>
            </el-radio-group>
          </el-form-item>
          <el-form-item label="头像">
            <el-upload
                class="upload-demo"
                drag
                action="http://localhost:3000/upload"
                :on-success="handleAvatarSuccessEdit"
                :on-error="handleAvatarError"
                :show-file-list="false"
                :auto-upload="true">
              <i class="el-icon-upload"></i>
              <div class="el-upload__text">将文件拖到此处，或<em>点击上传</em></div>
              <div class="el-upload__tip" slot="tip" type="success">只能上传 JPG/PNG 文件，且不超过 2MB</div>
            </el-upload>
          </el-form-item>
        </el-form>

        <template #footer>
          <span class="dialog-footer">
            <el-button @click="editaddUserDialog = false">取 消</el-button>
            <el-button type="primary" @click="editUser">确 定</el-button>
          </span>
        </template>
      </el-dialog>
    </el-card>
  </div>
</template>

<script>
import { Setting, Edit, Delete, Search } from '@element-plus/icons-vue';
import { reactive, ref } from 'vue';
import axios from 'axios';
axios.defaults.baseURL = 'http://localhost:8081'; // 修改为新的基础URL

export default {
  components: {
    Setting,
    Edit,
    Delete,
    Search
  },
  mounted() {
    this.loadUserData();
  },
  setup() {
    const allData = ref([]);
    const departmentOptions = ref([
      { value: 'dept1', label: '部门1' },
      { value: 'dept2', label: '部门2' },
      { value: 'dept3', label: '部门3' }
    ]);
    return { allData, departmentOptions };
  },
  data() {
    return {
      searchQuery: '',
      page: {
        pagenum: 1,
        pagesize: 10,
      },
      addUserDialog: false,
      editaddUserDialog: false,
      addForm: {
        username: '',
        userNumber: '',
        password: '',
        mobile: '',
        department: '',
        gender: 0, // 默认性别为男
        avatar: '' // 新增字段用于存储头像
      },
      editForm: reactive({
        username: '',
        userNumber: '',
        password: '',
        mobile: '',
        department: '',
        gender: 0, // 默认性别为男
        avatar: '' // 新增字段用于存储头像
      }),
      ruleForm: {
        username: [{ required: true, message: '请输入用户名', trigger: 'blur' }],
        userNumber: [{ required: true, message: '请输入账号', trigger: 'blur' }],
        password: [{ required: true, message: '请输入密码', trigger: 'blur' }],
        mobile: [{ required: true, message: '请输入手机', trigger: 'blur' }],
        department: [{ required: true, message: '请输入部门', trigger: 'blur' }],
        gender: [{ required: true, message: '请选择性别', trigger: 'change' }]
      },
      roleOption: [
        { value: '1111', label: 'Admin' },
        { value: '1000', label: 'User' }
      ],
      selectedUsers: [],
      defaultAvatar: 'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png' // 默认头像
    }
  },
  methods: {
    handleSelectionChange(val) {
      this.selectedUsers = val;
    },
    handleCurrentChange(val) {
      this.page.pagenum = val;
    },
    handleSizeChange(val) {
      this.page.pagesize = val;
      this.page.pagenum = 1; // Reset to the first page on page size change
    },
    loadUserData() {
      axios.get('/bg/users')
          .then((response) => {
            const users = response.data.map(user => ({
              id: user.userId,
              username: user.userName,
              userNumber: user.userNumber,
              password: user.userPassword,
              mobile: user.contactInfo,
              department: user.department,
              gender: user.userGender,
              role_name: user.typeId,
              create_time: user.timeCreate,
              update_time: user.timeModify,
              avatar: user.userImg || this.defaultAvatar,
              roleDisplay: user.typeId === 1111 ? 'Admin' : 'User',
              genderDisplay: user.userGender === 0 ? '男' : '女'
            }));
            this.allData = users;
          })
          .catch((error) => {
            console.error('获取用户数据失败:', error);
          });
    },

    handleAvatarSuccess(response, file) {
      // 头像上传成功后，将返回的头像 URL 存储到 addForm.avatar 中
      this.addForm.avatar = response.url; // 假设后端返回的 URL 在 response.url 中
    },

    handleAvatarSuccessEdit(response, file) {
      // 头像上传成功后，将返回的头像 URL 存储到 editForm.avatar 中
      this.editForm.avatar = response.url; // 假设后端返回的 URL 在 response.url 中
    },

    handleAvatarError(err, file) {
      this.$message.error('头像上传失败');
    },

    userAdd() {
      this.$refs.formRef.validate((valid) => {
        if (!valid) {
          this.$message.error('请填写完整的用户信息');
          return;
        }
        const newUser = {
          userName: this.addForm.username,
          userNumber: this.addForm.userNumber,
          userPassword: this.addForm.password,
          contactInfo: this.addForm.mobile,
          department: this.addForm.department,
          userGender: this.addForm.gender,
          userImg: this.addForm.avatar || '', // 如果没有上传头像，默认为空
          typeId: '1000' // 默认角色
        };

        axios.post('/bg/users', newUser)
            .then((res) => {
              if (res.status === 200) {
                this.$message.success('用户添加成功');
                this.loadUserData();
                this.addUserDialog = false;
                this.addForm = {};
              } else {
                this.$message.error('用户添加失败');
              }
            })
            .catch((err) => {
              console.error('请求失败:', err);
              this.$message.error('用户添加失败');
            });
      });
    },
    async edit(id) {
      const user = this.paginatedUsers.find((item) => item.id === id);
      this.editForm = {...user}; // Deep copy user data
      this.editaddUserDialog = true; // Open the edit dialog
    },

    editUser() {
      this.$refs.editFormRef.validate((valid) => {
        if (!valid) return this.$message.error('表单验证失败');
        axios.put(`/bg/users/${this.editForm.id}`, {
          userName: this.editForm.username,
          userNumber: this.editForm.userNumber,
          userPassword: this.editForm.password,
          contactInfo: this.editForm.mobile,
          department: this.editForm.department,
          userGender: this.editForm.gender,
          userImg: this.editForm.avatar // Include avatar if updated
        }).then((res) => {      
          if (res.status === 200) {
            this.$message.success('用户编辑成功');
            this.editaddUserDialog = false; // Close the dialog
            this.loadUserData(); // Refresh the user list
          } else {
            this.$message.error('编辑失败');
          }
        }).catch((err) => {
          console.error(err);
          this.$message.error('编辑失败，请重试');
        });
      });
    },
    deleteUser(id) {
      this.$confirm('此操作将永久删除该用户, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        axios.delete(`/bg/users/${id}`).then((res) => {
          if (res.status === 204) {
            this.$message.success('删除成功');
            this.loadUserData();
          } else {
            this.$message.error('删除失败，请重试');
          }
        })
      }).catch(() => {
        this.$message.info('删除取消');
      })
    },
    getRolename(typeid) {
      return typeid === 1111 ? 'Admin' : 'User'; // 简化角色获取
    }
  },
  computed: {
    filteredUsers() {
      if (!this.searchQuery.trim()) {
        return this.allData; // 如果搜索框为空，返回所有数据
      }
      return this.allData.filter(user =>
          (user.username || '').includes(this.searchQuery) ||
          (user.mobile || '').includes(this.searchQuery) ||
          (user.department || '').includes(this.searchQuery) ||
          (user.userNumber || '').includes(this.searchQuery) || // 添加 userNumber 的搜索
          (this.getRolename(user.role_name) || '').includes(this.searchQuery) ||
          (user.genderDisplay || '').includes(this.searchQuery) // 添加 genderDisplay 的搜索
      );
    },
    paginatedUsers() {
      const start = (this.page.pagenum - 1) * this.page.pagesize;
      const end = start + this.page.pagesize;
      return this.filteredUsers.slice(start, end); // 使用 filteredUsers 进行分页
    }
  },
}
</script>

<style>
.el-card {
  margin-top: 15px;
}
</style>
