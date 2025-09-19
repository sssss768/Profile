<template>
	<div class="index-container" ref="container">
		<UserHeader :user="user" />
        <UserMain id="main" :user="user"/>
		 <UserInfo id="info" :user="user"/>
	<UserFood id="food" :user="user"/>
		<UserScenery id="scenery" :user="user"/>
		<UserCulture id="culture" :user="user"/>
		
	</div>
</template>

<script lang="ts" setup>
import '@/assets/css/User.css';
import '@/assets/css/Variable.css';
import 'element-plus/dist/index.css'
import '@/assets/css/Message.css';
import { onMounted, ref } from "vue";
import usePassiveScroll from "@/hooks/usePassiveScroll";
import titleAndPath from "@/utils/TitleAndPath";
import setCss from "@/utils/setCss";
import UserHeader from "./components/UserHeader.vue";
import UserMain from "./components/UserMain.vue";
import { mapToUser, type User } from '../../types/user';
import UserInfo from "./components/UserInfo.vue";
import UserFood from "./components/UserFood.vue";
import UserScenery from './components/UserScenery.vue';
import UserCulture from './components/UserCulture.vue';



const userForm = history.state?.data?.row[0] || null;
const user = userForm ? mapToUser(userForm) : null;

console.log("user.vue获取到user",user)
const container = ref<HTMLElement | null>(null);
usePassiveScroll(titleAndPath);
onMounted(() => {
	// 根据读取到的内容变样式
	if (localStorage.getItem("dayOrNight")) {
		setCss(localStorage.getItem("dayOrNight") === "day");
	} else {
		setCss(true);
	}
});
</script>

<style scoped>
.index-container {
	position: relative;
	width: 100%;
	min-height: 100vh;
	background-color: var(--overall-background-color);
	transition: all 0.4s;
}
</style>




<!-- <template> 
    <div style="padding: 20px;">
        
        <div v-if="user">
            <h1>登录成功</h1>
            <p><strong>用户名:</strong> {{ user.userName }}</p>
            <p><strong>邮箱:</strong> {{ user.email }}</p>
            <p><strong>真实姓名:</strong> {{ user.realName }}</p>
            <p><strong>性别:</strong> {{ formatGender(user.gender) }}</p>
            <p><strong>电话:</strong> {{ user.phone }}</p>
            <p><strong>部门:</strong> {{ user.office }}</p>
            <p><strong>办公地址:</strong> {{ user.officeAdress }}</p>
            <p><strong>描述:</strong> {{ user.desc }}</p>
            <p><strong>头像:</strong></p>
            <img :src="user.img" alt="头像" style="width: 100px; height: 100px; border-radius: 50%; object-fit: cover;" />
        </div>
        
        <div v-else>
            <p>没有提交数据/提交失败，请返回</p>
            <el-button type="primary" @click="goBack">返回</el-button>
        </div>
    </div>
</template>

<script lang="ts" setup>
import { useRouter } from 'vue-router';

const router = useRouter();

const user = history.state?.data.row[0] || null;
const goBack = () => {
    router.push('@/views/student/Login.vue'); // 跳回表单页面或其他默认页面
};

// 格式化性别显示
const formatGender = (gender: number | null) => {
    if (gender === 1) return '男';
    if (gender === 2) return '女';
    return '未知';
}; </script> -->