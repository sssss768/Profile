<script setup lang="ts">
import { ref } from "vue";
import { Sunny, Moon } from "@element-plus/icons-vue";
import setCss from "@/utils/setCss";

// 实现昼夜切换的那个开关的组件
const dayOrNight = ref<boolean>(
	!localStorage.getItem("dayOrNight") ||
		localStorage.getItem("dayOrNight") === "day"
);
function changeTheme(newVal: boolean) {
	dayOrNight.value = newVal;
	localStorage.setItem("dayOrNight", newVal ? "day" : "night");
	setCss(newVal);
}
</script>

<template>
	<div @click.stop>
		<el-switch
			v-model="dayOrNight"
			class="ml-2"
			style="
				--el-switch-on-color: rgb(209, 209, 209);
				--el-switch-off-color: rgb(78, 78, 82);
			"
			:active-action-icon="Sunny"
			:inactive-action-icon="Moon"
			@change="changeTheme"
		/>
	</div>
</template>

<style scoped></style>
