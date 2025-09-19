<template>
    <div>
      <el-card class="box-card" style="max-width: 400px">
        <template #header>
          <div class="clearfix">
            计算圆的周长和面积&emsp;&emsp;&emsp;半径：
            <el-input v-model="radius" style="width: 100px;"></el-input>
          </div>
        </template>
        <div>
          <br>半径&emsp; {{ getRadius }}
          <br>周长&emsp; {{ getP }}
          <br>面积&emsp; {{ getCircleArea }}
        </div>
      </el-card>
      <br><br>
      <el-card class="box-card" style="max-width: 400px">
        <template #header>
          <div class="clearfix">
            计算梯形的面积&emsp;&emsp;&emsp;
            <br><br>上底：
            <el-input v-model="a" style="width: 100px;"></el-input>
            <br>下底：
            <el-input v-model="baseline" style="width: 100px;"></el-input>
            <br>高:&emsp;&nbsp;&nbsp;&nbsp;
            <el-input v-model="high" style="width: 100px;"></el-input>
          </div>
        </template>
        <div>
          <br>面积&emsp; {{ getArea }}
        </div>
      </el-card>
    </div>
  </template>
<script lang="ts" setup>
import { ref, computed } from 'vue';

const radius = ref(0);
const a = ref(0);
const baseline = ref(0);
const high = ref(0);

const getRadius = computed(() => {
  return isNaN(Number(radius.value)) ? NaN : radius.value;
});

const getP = computed(() => {
  return radius.value * Math.PI * 2;
});

const getCircleArea = computed(() => {
  return Math.PI * radius.value ** 2;
});

const getArea = computed(() => {
  return ((Number(a.value) + Number(baseline.value)) * Number(high.value)) / 2;
});
</script>

<style scoped>
.box-card {
  margin-bottom: 20px;
}
</style>