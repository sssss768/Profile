<template>
  <!-- 加载动画 -->
  <div class="loadBox" v-if="isLoading">
    <main class="loader-container">
      <div class="loader-state">
        <svg class="nyan" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"
          viewBox="0 0 47 20">
          <defs>
            <linearGradient id="rainbow-colors" x1="0.5" x2="0.5" y2="1">
              <stop class="rainbow-color1" offset="0" />
              <stop class="rainbow-color1" offset="0.167" />
              <stop class="rainbow-color2" offset="0.167" />
              <stop class="rainbow-color2" offset="0.335" />
              <stop class="rainbow-color3" offset="0.335" />
              <stop class="rainbow-color3" offset="0.5" />
              <stop class="rainbow-color4" offset="0.5" />
              <stop class="rainbow-color4" offset="0.669" />
              <stop class="rainbow-color5" offset="0.669" />
              <stop class="rainbow-color5" offset="0.833" />
              <stop class="rainbow-color6" offset="0.833" />
              <stop class="rainbow-color6" offset="1" />
            </linearGradient>
          </defs>
          <g class="rainbow">
            <rect />
            <rect />
            <rect />
            <rect />
            <rect />
            <rect />
          </g>
          <g class="pig">
            <g class="foot" transform="translate(52)">
              <rect width="1" height="3" transform="translate(6 13)" />
              <rect width="1" height="3" transform="translate(8 13)" />
              <rect width="1" height="3" transform="translate(14 13)" />
              <rect width="1" height="3" transform="translate(12 13)" />
            </g>
            <g class="tail">
              <rect width="1" height="1" transform="translate(4 10)" />
              <rect width="1" height="1" transform="translate(3 11)" />
            </g>

            <g transform="translate(52)">
              <rect class="body1" width="8" height="8" transform="translate(7 6)" />
              <rect class="body1" width="10" height="8" transform="translate(6 7)" />
              <rect class="body1" width="12" height="6" transform="translate(5 8)" />
              <rect class="body2" width="10" height="6" transform="translate(6 8)" />
              <rect class="body2" width="8" height="6" transform="translate(7 7)" />
              <rect class="stains" width="4" height="1" transform="translate(7 13)" />
              <rect class="stains" width="2" height="1" transform="translate(8 12)" />
              <rect class="stains" width="2" height="1" transform="translate(6 9)" />
              <rect class="stains" width="3" height="1" transform="translate(6 8)" />
              <rect class="stains" width="3" height="1" transform="translate(7 7)" />
              <rect class="stains" width="1" height="1" transform="translate(14 7)" />
            </g>
            <g class="ears" transform="translate(52)">
              <rect width="1" height="3" transform="translate(10 5)" />
              <rect width="1" height="3" transform="translate(15 5)" />
            </g>
            <g class="snout">
              <rect class="snout1" width="5" height="3" transform="translate(13 10)" />
              <rect class="snout-holes" width="1" height="3" transform="translate(17 11) rotate(90)" />
              <rect class="snout2" width="1" height="1" transform="translate(16 11) rotate(90)" />
            </g>
            <g class="eyes">
              <rect width="1" height="1" transform="translate(12 9)" />
              <rect width="1" height="1" transform="translate(15 9)" />
            </g>
          </g>
        </svg>
      </div>
      <span class="loader-text">小小小xjn</span>
      <div class="background-container">
        <div class="stars"></div>
      </div>
    </main>
  </div>

  <!-- 主页 -->
  <div v-else>
    <div class="bgGrid">
      <div class="Grid" v-motion :initial="{ opacity: 0, y: -25 }" :enter="{ opacity: 1, y: 0 }" :duration="1000">
        <div class="mask"></div>
        <div class="itemGrid-row" v-for="i in gridRows" :key="i">
          <div class="itemGrid-cols" v-for="j in gridCols" :key="j"></div>
        </div>
      </div>
    </div>
    <div class="main" v-motion :initial="{ opacity: 0 }" :enter="{ opacity: 1 }" :duration="1000">
      <div class="info">
        <div class="header">
          <img src="@/assets/CJLU.jpg" alt="">
        </div>
        <div class="infoText">
          <h1>请登录</h1>
          <h1>个人<span class="qn">中心</span></h1>
        </div>
      </div>
      <div class="typewriter">
        <i class="iconfont icon-baojiaquotation2"></i>
        大作业 22034160217
        <i class="iconfont icon-baojiaquotation"></i>
      </div>

      <div class="btns">
        <vs-button class="lastBtn" color="#FACB1E" animation-type="scale" @click="showLogin">
          <i class="iconfont icon-user"></i>
          <template #animate>
            登录
          </template>
        </vs-button>
        <vs-button class="lastBtn" color="#D81E06" animation-type="scale" @click="showRegister">
          <i class="iconfont icon-register"></i>
          <template #animate>
            注册
          </template>
        </vs-button>
        <vs-button class="lastBtn" color="#457B9D" animation-type="scale" @click="active = true">
          <i class="iconfont icon-about"></i>
          <template #animate>
            关于
          </template>
        </vs-button>
      </div>
    </div>
    <div class="footer">
      By Sean | ©2024
    </div>


    <vs-dialog overlay-blur width="550px" not-center v-model="activeLogin">
      <div class="con-content">
        <vs-alert color="#FACB1E" type="gradient" v-model:hidden-content="loginHidden">
          <template #title>登录</template>
          <el-form ref="LoginForm" style="max-width: 600px" :model="loginForm" status-icon label-width="auto"
            class="Form">
            <el-form-item>
              <el-input v-model="loginForm.email" prefix-icon="UserFilled" placeholder="Email"></el-input>
            </el-form-item>
            <el-form-item>
              <el-input v-model="loginForm.password" prefix-icon="Briefcase" type="password" autocomplete="off"
                placeholder="Password" clearable="true" show-password />
            </el-form-item>
          </el-form>
          <div style="display: flex; justify-content: flex-end; gap: 10px;">
            <vs-button color="#909399" @click="resetLoginForm">
              重置
            </vs-button>
            <vs-button color="#fe8599" @click="Login">
              登录
            </vs-button>
          </div>
        </vs-alert>



        <vs-alert color="#D81E06" type="gradient" v-model:hidden-content="registerHidden">
          <template #title>注册</template>
          <el-form ref="registerFormRef" style="max-width: 600px" :model="Form" status-icon label-width="auto"
            :rules="rules" class="Form">
            <el-form-item prop="name">
              <el-input v-model="Form.name" placeholder=" 用户名"></el-input>
            </el-form-item>
            <el-form-item prop="email">
              <el-input v-model="Form.email" placeholder=" 邮箱地址" />
            </el-form-item>
            <el-form-item prop="pass">
              <el-input type="password" autocomplete="off" v-model="Form.pass" placeholder=" 设置密码" />
            </el-form-item>
            <el-form-item prop="checkPass">
              <el-input type="password" autocomplete="off" v-model="Form.checkPass" placeholder=" 确认密码" />
            </el-form-item>
            <el-form-item prop="realName">
              <el-input v-model="Form.realName" placeholder=" 真实姓名" />
            </el-form-item>
            <el-form-item prop="sex">
              <el-select v-model="Form.sex" placeholder="性别" style="width: 150px;">
                <el-option label="男" value="male"></el-option>
                <el-option label="女" value="female"></el-option>
              </el-select>
              <el-upload class="upload-demo" :http-request="httpRequest" :before-upload="beforeUpload"
                :on-remove="handleRemove"  :limit="1">
                <el-button type="primary" class="register-upload-button">上传头像</el-button>
                <template #tip>
                  <div class="el-upload__tip">
                  </div>
                </template>
              </el-upload>
            </el-form-item>
          </el-form>
          <div style="display: flex; justify-content: flex-end; gap: 10px;">
            <vs-button color="#909399" @click="resetRegisterForm(registerFormRef)">
              重置
            </vs-button>
            <vs-button color="#fe8599" @click="register(registerFormRef)">
              注册
            </vs-button>
          </div>
        </vs-alert>
      </div>
      <template #footer>
        <div class="con-footer">
          <div class="reTheme">
            <input type="radio" id="light" name="theme" :checked="theme == 'light'">
            <label @click="setTheme('light')" for="light">
              <i class="iconfont icon-sun"></i>
            </label>
            <input type="radio" id="dark" name="theme" :checked="theme == 'dark'">
            <label @click="setTheme('dark')" for="dark">
              <i class="iconfont icon-moon"></i>
            </label>
            <div class="checkedBg"></div>
          </div>
          <div class="footerBtn">
            <vs-button color="#fe8599" @click="activeLogin = false">
              返回
            </vs-button>
          </div>
        </div>
      </template>
    </vs-dialog>





    <vs-dialog overlay-blur width="550px" not-center v-model="active">

      <div class="con-content">
        <vs-alert color="#FE8599" type="gradient" v-model:hidden-content="techHidden">
          <template #title>技术栈</template>
          <p>网站基于以下技术搭建和部署</p>
          <vs-avatar-group class="aboutAva" float max="8">
            <vs-tooltip placement="top" v-for="i in avaters" :key="i.content">
              <vs-avatar :color="i.color">
                <i :class="`iconfont ${i.icon}`"></i>
              </vs-avatar>
              <template #content>{{ i.content }}</template>
            </vs-tooltip>
          </vs-avatar-group>
        </vs-alert>
        <vs-alert color="#00BCD4" type="gradient" v-model:hidden-content="aboutHidden">
          <template #title>介绍</template>
          <p><b>前端实现了以下功能</b></p>
          <p><b>&nbsp;用户登录</b>&nbsp;用户登录和注册的功能</p>
          <p><b>&nbsp;信息展示</b>&nbsp;显示个人信息,家乡美食,家乡景点,家乡文化</p>
          <p><b>&nbsp;数据修改</b>&nbsp;提供对以上四张表单的信息增删查改功能</p>
          <br>
          <p><b>后端实现了以下功能</b></p>
          <p><b>&nbsp;数据接收</b>&nbsp;响应前端行为, 并返回结果</p>
          <p><b>&nbsp;信息修改</b>&nbsp;对对应的数据库表格信息进行修改</p>
          <p><b>&nbsp;登录校验与拦截器</b>&nbsp;使用Jwt令牌进行登录校验,确保登录的安全性</p>
        </vs-alert>
      </div>
      <!-- 改变主题颜色 -->
      <template #footer>
        <div class="con-footer">
          <div class="reTheme">
            <input type="radio" id="light" name="theme" :checked="theme == 'light'">
            <label @click="setTheme('light')" for="light">
              <i class="iconfont icon-sun"></i>
            </label>
            <input type="radio" id="dark" name="theme" :checked="theme == 'dark'">
            <label @click="setTheme('dark')" for="dark">
              <i class="iconfont icon-moon"></i>
            </label>
            <div class="checkedBg"></div>
          </div>
          <!-- 返回按钮 -->
          <div class="footerBtn">
            <vs-button color="#fe8599" @click="active = false">
              OK
            </vs-button>
          </div>
        </div>
      </template>
    </vs-dialog>
  </div>
</template>

<script lang="ts">
import { defineComponent, ref, onMounted, reactive } from 'vue';
import { VsButton, VsAvatar, VsTooltip, VsDialog, VsNotification, VsAlert } from 'vuesax-alpha'
import 'vuesax-alpha/dist/index.css'
import 'vuesax-alpha/theme-chalk/dark/css-vars.css'
import '@/assets/less/Login.less'
import '@/assets/css/LoginStyle.css'
import '@/assets/css/LoginLoad.css';
import axios from 'axios';
import router from '../../router';
import axiosInstance from '../../utils/Axios';
import { type UserForm } from '../../types/user';
import type { FormInstance, FormRules, UploadProps } from 'element-plus'

export default defineComponent({
  name: 'YourComponent',
  components: {
    VsButton, VsAvatar, VsTooltip, VsDialog, VsNotification, VsAlert
  },
  setup() {
    const isLoading = ref(true);
    const techHidden = ref<boolean>(true);
    const aboutHidden = ref<boolean>(true);
    const loginHidden = ref<boolean>(true);
    const registerHidden = ref<boolean>(true);
    const btnList = ref([]);

    //登录处理
    const loginForm = reactive({
      email: '',
      password: '',
    });
    const showLogin = () => {
      activeLogin.value = true;
      loginHidden.value = false;
      registerHidden.value = true;
    };
    const showRegister = () => {
      activeLogin.value = true;
      loginHidden.value = true;
      registerHidden.value = false;
    };
    const Login = async () => {
      let params = JSON.stringify(loginForm)
      let url = '/api/login'
      try {
        const response = await axios.post(url, params, {
          headers: {
            'Content-Type': 'application/json'
          }
        })
        if (response.data.code == 1) {
          const token = response.data.data
          localStorage.setItem('token', token)
          const res = await axiosInstance.get('/api/users', {
            params: {
              email: loginForm.email
            }
          })
          console.log(res.data)
          router.push({
            path: './User',
            state: { data: res.data.data }
          })
        }
        else {
          alert('登陆失败')
        }
      } catch (error) {
        console.error('登陆失败', error)
        alert('登陆失败')
      }
    }
    const resetLoginForm = () => {
      loginForm.email = '';
      loginForm.password = '';
    };

    // 注册
    const registerFormRef = ref<FormInstance>()

    const Form = reactive<UserForm>({
      name: '',
      email: '',
      pass: '',
      checkPass: '',
      realName: '',
      sex: '',
      fileList: [] as File[],
    })

    const resetRegisterForm = (formEl: FormInstance | undefined) => {
      if (!formEl) return
      formEl.resetFields()
    }

    const validatePass = (rule: any, value: any, callback: any) => {
      if (value === '') {
        callback(new Error('请输入密码'))
      } else if (value.length < 6 || value.length > 15) {
        callback(new Error('密码长度应为6-15个字符'))
      } else {
        if (Form.checkPass !== '') {
          if (!registerFormRef.value) return
          registerFormRef.value.validateField('checkPass')
        }
        callback()
      }
    }
    const validatePass2 = (rule: any, value: any, callback: any) => {
      if (value === '') {
        callback(new Error('请再次输入密码'))
      } else if (value !== Form.pass) {
        callback(new Error('两次输入密码不一致!'))
      } else {
        callback()
      }
    }

    const rules = reactive<FormRules<typeof Form>>({
      pass: [{ validator: validatePass, trigger: 'blur' }],
      checkPass: [{ validator: validatePass2, trigger: 'blur' }],
      email: [
        { required: true, message: '请输入邮箱地址', trigger: 'blur' },
        { type: 'email', message: '请输入正确的邮箱地址', trigger: ['blur', 'change'] }
      ],
    })

    const beforeUpload = (file: File) => {
      console.log("文件准备上传：", file.name);
      return true;
    };

    const handleRemove: UploadProps['onRemove'] = (file, uploadFiles) => {
      console.log(file, uploadFiles)
    }

    const httpRequest = async (option: any) => {
      Form.fileList.push(option.file)
      console.log(Form.fileList[0])
    }

    const register = async (formEl: FormInstance | undefined) => {
      if (!formEl) return
      formEl.validate(async (valid) => {
        if (valid) {
          console.log('Valid form data:', Form);

          const formData = new FormData();
          formData.append('name', Form.name);
          formData.append('email', Form.email);
          formData.append('pass', Form.pass);
          formData.append('realName', Form.realName);
          formData.append('sex', Form.sex);

          Form.fileList.forEach((file: any) => {
            formData.append('img', file);
          });
          console.log("提交", formData)
          try {
            const res = await axios.post('/api/login/register', formData, {
              headers: {
                'Content-Type': 'multipart/form-data',
              },
            });
            console.log('Form submitted successfully:', res.data);
            if (res.data.code === 1) {
              loginForm.email = Form.email;
              loginForm.password = Form.pass;
              showLogin();
              alert('注册成功');
            } else {
              console.error('后端返回错误:', res.data.msg);
            }
          } catch (error) {
            console.error('Error submitting form:', error);
          }
        } else {
          console.log('error submit!');
        }
      })
    }

    // 技术栈图标
    const avaters = ref([
      { color: '#FFBA00', icon: 'icon-Vite', content: 'Vite' },
      { color: '#7DB150', icon: 'icon-SpringBoot', content: 'SpringBoot' },
      { color: '#65B687', icon: 'icon-Vue', content: 'Vue3' },
      { color: '#409EFF', icon: 'icon-Element-Plus', content: 'Element Plus' },
      { color: '#007ACC', icon: 'icon-TypeScript', content: 'TypeScript' },
      { color: '#32738C', icon: 'icon-MySQL', content: 'MySQL' },
      { color: '#303D4E', icon: 'icon-Vuesax', content: 'Vuesax for Vue3' },
      { color: '#23355A', icon: 'icon-Less', content: 'Less' }
    ]
    );

    const upTime = ref<string>('2024-09-16');
    const version = ref<string>('beta3');
    const gridRows = ref<number>(9);
    const gridCols = ref<number>(5);
    const active = ref<boolean>(false);
    const activeLogin = ref<boolean>(false);
    const isDarkMode = ref<boolean>(true);
    const theme = ref<string>('light'); // 默认亮色

    onMounted(() => {
       setTimeout(() => {
         isLoading.value = false;
       }, 800);
      if (localStorage.getItem('isTheme')) {
        theme.value = localStorage.getItem('isTheme')!;
        applyTheme();
      } else {
        applyTheme();
      }
      // 监听系统主题变化
      window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', applyTheme);

    });


    // 设置主题
    const setTheme = (mode: string) => {
      theme.value = mode;
      localStorage.setItem('isTheme', mode);
      applyTheme();
    };
    const applyTheme = () => {
      const themeToApply = theme.value === 'light' ? 'light' : 'dark';
      document.documentElement.setAttribute('data-theme', themeToApply);
    };

    return {
      isLoading,
      techHidden,
      aboutHidden,
      btnList,
      avaters,
      upTime,
      version,
      gridRows,
      gridCols,
      active,
      isDarkMode,
      theme,
      activeLogin,
      loginHidden,
      registerHidden,
      loginForm,
      Form,
      registerFormRef,
      rules,
      beforeUpload,
      httpRequest,
      handleRemove,
      resetRegisterForm,
      register,
      Login,
      setTheme,
      showLogin,
      showRegister,
      resetLoginForm
    };
  }
})
</script>


<style lang="less">
@import url(//at.alicdn.com/t/c/font_4791620_17b2ctsg2em.css);
</style>

<style scoped>
@import url('https://fonts.googleapis.cn/css2?family=JetBrains+Mono:ital,wght@0,100..800;1,100..800&display=swap');
</style>
