<script setup lang="ts">
import { ref, onMounted, onUnmounted } from "vue";

//生成随机数的函数
function getRandom(left: number, right: number) {
	return Math.ceil(Math.random() * (right - left + 1)) + left - 1;
}

const snowArr = ref<number[]>([]);
let count: number = 0;
const generateSnowflakes = () => {
	let count2 = window.innerWidth > 300 ? 25 : 15;
	if (count === count2) {
		return;
	}
	count = count2;
	snowArr.value = Array.from({ length: count }, () => getRandom(1, 10));
};

onMounted(() => {
	generateSnowflakes();
	window.addEventListener("resize", generateSnowflakes);
});

onUnmounted(() => {
	window.removeEventListener("resize", generateSnowflakes);
});
</script>

<template>
	<div class="container">
		<div class="loader">
			<div class="snow">
				<span
					v-for="(item, index) in snowArr"
					:style="{ '--i': item }"
					:key="index"
				></span>
			</div>
		</div>
	</div>
</template>

<style scoped>
.container {
	display: flex;
	justify-content: center;
	align-items: center;
	width: 100%;
	height: 100%;
	background-color: transparent;
}

.loader {
	position: relative;
	width: 220px;
	height: 60px;
	border-radius: 200px;
	background-color: var(--font-main-color);
}

.loader::before {
	content: "";
	position: absolute;
	width: 60px;
	height: 60px;
	background: var(--font-main-color);
	border-radius: 50%;
	box-shadow: 80px 0 0 40px var(--font-main-color);
	left: 20px;
	top: -40px;
}

.snow {
	position: absolute;
	display: flex;
	z-index: 1;
	left: 50%;
	top: 50%;
	transform: translate(-50%, -50%);
}

@keyframes snowing {
	0% {
		transform: translateY(0);
	}
	70% {
		/* 稍微一停再消失 */
		transform: translateY(150px) scale(1);
	}
	100% {
		/* 下落过程中雪花大小逐步变为0 */
		transform: translateY(150px) scale(0);
	}
}

.snow span {
	position: relative;
	width: 3px;
	height: 3px;
	background: var(--font-main-color);
	margin: 0 2px;
	border-radius: 50%;
	animation: snowing 8s linear infinite;
	/* 设置随机持续时间出现 */
	animation-duration: calc(20s / var(--i));
}

@media screen and (max-width: 300px) {
	.loader {
		width: 110px;
		height: 30px;
	}
	.loader::before {
		width: 30px;
		height: 30px;
		box-shadow: 40px 0 0 20px var(--font-main-color);
		left: 10px;
		top: -20px;
	}
}
</style>
