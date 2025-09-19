<template>
    <div class="main-index-cantainer">
        <div v-if="user">
            <div class="basic-container text-container">
                <p class="main-text">沈力诚</p>
                <p class="tell-text">-22H034160217</p>
                <p class="tell-text">-3074548601@qq.com </p>
                <p class="tell-text">-13735843460</p>
                <p class="tell-text">-信息工程学院</p>
                <a class="index-staret-btn" href="#info">Let's Start</a>
            </div>
            <NextArrow to="#info" />
        </div>
        <div v-else>
            <div class="basic-container text-container">
                <p class="main-text">未登录&emsp;</p>
                <p class="tell-text">- 请返回登陆页面</p>
                <a class="index-staret-btn" href="/userLogin">返回</a>
            </div>
            <NextArrow to="/userLogin" />
        </div>
        <div class="basic-container cloud-container" ref="container">
            <LittleCloud />
        </div>

    </div>
</template>

<script setup lang="ts">
import NextArrow from "@/components/NextArrow.vue";
import LittleCloud from "@/views/student/components/cloud/LittleCloud.vue";
import { type User } from "../../../types/user";
const props = defineProps<{
    user: User | null;
}>();
if (props.user) {
    const user = props.user;
}
</script>

<style scoped>
@keyframes opp {
    0% {
        opacity: 0;
        transform: translateY(-3vh);
    }

    100% {
        opacity: 1;
        transform: translateY(0);
    }
}

.main-index-cantainer {
    position: relative;
    width: 100%;
    height: 90vh;
    display: flex;
    justify-content: space-around;
    align-items: center;
    flex-wrap: wrap;
    align-content: space-around;
}

.basic-container {
    position: relative;
    width: 40vw;
    height: 80vh;
    background-color: transparent;
    border-radius: 10%;
}

.text-container {
    flex-direction: column;
    display: flex;
    justify-content: center;
    align-items: center;
    flex-wrap: wrap;
    align-content: center;
    font-weight: 300;
    color: var(--font-main-color);
    background-color: transparent;
    animation: opp 0.6s linear 1 forwards;
    user-select: none;
}


.cloud-container {
    box-shadow: none;
    overflow: hidden;
}

.main-text {
    display: block;
    position: relative;
    top: -2vh;
    font-size: max(5vw, 2.5rem);
}

.tell-text {
    margin-top: 1vh;
    width: 55%;
    font-size: max(1vw, 1rem);
}

.index-staret-btn {
    margin-top: 3vh;
    display: flex;
    justify-content: center;
    align-items: center;
    text-decoration: none;
    width: 60%;
    height: 8%;
    font-size: max(1vw, 1.3rem);
    color: var(--font-main-color);
    border: 1px solid var(--font-main-color);
    border-radius: 20px;
    background-color: transparent;
    transition: all 0.3s;
}

.index-staret-btn:hover {
    box-shadow: 0 0 30px var(--color-box-shadow);
}

@media screen and (max-width: 768px) {
    .tell-text {
        display: none;
    }

    .index-staret-btn {
        display: none;
    }

    .text-container {
        width: 80vw;
        height: auto;
    }

    .cloud-container {
        width: 80vw;
        height: 65vh;
    }
}
</style>
