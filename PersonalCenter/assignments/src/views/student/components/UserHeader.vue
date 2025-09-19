<template>
	<nav class="index-header-container">
		<a class="index-header-logo">
			<img v-if="isUser" src="@/assets/CJLU.jpg" alt="School" class="school-image" />
			<img v-if="isUser" :src="user.img" alt="user" class="school-image" />
			<span v-if="isUser">&nbsp;基于JavaWeb开发 &nbsp;的期末大作业</span>
			<span v-else>未登录</span>
		</a>
		<div class="index-header-all">
			<a v-for="(item, index) in partTitleAndPath" :key="index" :href="item.path"
				@click="changeIndex(index + 1)">{{ item.name }}</a>
			<DayNightSwitch />
		</div>
		<div class="index-header-sub">
			<el-icon size="1.4rem" class="index-menu-icon" @click="changeItems">
				<CloseBold v-if="showItem" />
				<Menu v-else />
			</el-icon>
		</div>
		<div class="index-header-sub-item-container" v-show="showItem" @click="changeItems">
			<!-- 小屏模式下的下拉框 -->
			<div class="item-content">
				<div class="index-header-sub-item" v-for="(item, index) in partTitleAndPath" :key="index"
					:href="item.path">
					<a :href="item.path" @click="changeIndex(index + 1)">{{
						item.name
					}}</a>
				</div>
				<div class="index-header-sub-item item-theme">
					<span style="user-select: none">主题</span>
					<DayNightSwitch />
				</div>
			</div>
		</div>
	</nav>
</template>

<script setup lang="ts">
import { ref, inject } from "vue";
import { partTitleAndPath } from "@/utils/TitleAndPath";
import DayNightSwitch from "@/components/DayNightSwitch.vue";
import type { User } from "typescript";
let isUser = false;
const props = defineProps<{
	user: User | null;
}>();
if (props.user) {
	const user = props.user;
	isUser = true;
}

console.log("isUser:", isUser)


// 小屏效果下点击出现菜单
const showItem = ref<boolean>(false);
const { changeIndex } = inject(
	"passiveScrollHandler"
) as usePassiveScroll.passiveScrollHandler;
function changeItems() {
	showItem.value = !showItem.value;
}


</script>

<style scoped>
.index-header-container {
	display: flex;
	justify-content: space-around;
	align-items: center;
	position: sticky;
	left: 0;
	top: 0;
	width: 100%;
	height: 10vh;
	background-color: var(--overall-background-color);
	border-bottom: 1px solid var(--solid-color);
	z-index: 99;
	transition: all 0.4s;
}

.font-light {
	text-shadow: 0 0 10px #fff;
}

.index-header-container a,
.index-header-container span {
	text-decoration: none;
	color: var(--font-main-color);
}

.index-header-logo {
	display: flex;
	justify-content: center;
	align-items: center;
	width: 20vw;
	height: 10vh;
	font-weight: var(--font-weight);
	font-size: clamp(1.5rem, 2.4vw, 60%);
	color: var(--font-main-color);
	user-select: none;
	margin-left: -50px;
}

.school-image {
	max-width: 60%;
	max-height: 60%;
	object-fit: contain;
	border-radius: 50%;
}

.index-header-all {
	display: flex;
	justify-content: space-evenly;
	align-items: center;
	width: 40vw;
	height: 10vh;
	margin-left: 200px;
}

.index-header-all a {
	font-weight: var(--font-weight);
	font-size: 1.1rem;
	transition: all 0.2s;
}

.index-menu-icon {
	color: var(--font-main-color);
}

.index-header-all a:hover,
.index-header-sub a:hover,
.index-menu-icon:hover {
	color: var(--hover-color);
}

.index-header-sub {
	display: none;
}

.index-menu-icon {
	transition: all 0.2s;
	cursor: pointer;
}

@keyframes opa {
	0% {
		opacity: 0;
		transform: translateY(0);
	}

	100% {
		opacity: 1;
		transform: translateY(1vh);
	}
}

.index-header-sub-item-container {
	position: absolute;
	display: none;
	justify-content: center;
	align-items: flex-start;
	top: 10vh;
	width: 100%;
	height: 90vh;
	font-size: 1rem;
	background-color: var(--overall-background-color);
	transition: all 0.4s;
	z-index: 99;
}

.item-content {
	display: flex;
	justify-content: center;
	align-content: flex-start;
	flex-wrap: wrap;
	width: 90vw;
	height: 30vh;
	animation: opa 0.4s linear 1 forwards;
}

.index-header-sub-item {
	width: 51%;
	height: 7vh;
	display: flex;
	align-items: center;
	border-bottom: 1px solid var(--solid-color);
}

.index-header-sub-item a,
.index-header-sub-item span {
	transition: all 0.2s;
	font-weight: var(--font-weight);
	color: var(--font-main-color);
	text-decoration: none;
}

.item-theme {
	justify-content: space-between;
}

.index-header-sub-item a:hover {
	color: var(--hover-color);
}

@media screen and (max-width: 800px) {

	/* 对于小于800px的屏幕，应用这里的样式 */
	.index-header-all {
		display: none;
	}

	.index-header-sub-item-container {
		display: flex;
	}

	.index-header-sub {
		display: flex;
		align-items: center;
	}
}
</style>
