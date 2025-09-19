<template>
  <el-card class="box-card" style="max-width: 400px">
    <template #header>
      <div class="clearfix">
        计算梯形的面积<el-button style="float: right; padding: 3px 0" type="text" @click="getArea">计算面积</el-button>
        <br><br>上底：
        <el-input v-model="a" style="width: 100px;"></el-input>
        <br>下底：
        <el-input v-model="baseline" style="width: 100px;"></el-input>
        <br>高:&emsp;&nbsp;&nbsp;&nbsp;
        <el-input v-model="high" style="width: 100px;"></el-input>
      </div>
    </template>
    <div>
      <br>面积&emsp;{{ area }}
    </div>
  </el-card>
</template>

<script lang="ts" setup>
import { ref } from 'vue';
const a = ref(0);
const baseline = ref(0);
const high = ref(0);
const area = ref(0);

const getArea = () => {
  area.value =  ((Number(a.value) + Number(baseline.value)) * Number(high.value)) / 2;
};
</script>

<style></style>