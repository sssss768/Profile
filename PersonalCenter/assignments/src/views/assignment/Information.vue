<template>
    <div style="padding: 20px;">
        <!-- 数据展示 -->
        <div v-if="user">
            <h1>提交成功</h1>
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
        <!-- 没有数据 -->
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
    router.push('/assignments/experience'); // 跳回表单页面或其他默认页面
};

// 格式化性别显示
const formatGender = (gender: number | null) => {
    if (gender === 1) return '男';
    if (gender === 2) return '女';
    return '未知';
};
</script>