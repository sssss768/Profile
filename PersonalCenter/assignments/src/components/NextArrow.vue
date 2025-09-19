<script setup lang="ts">
  // 注意，必须要给使用此组件的父元素一个absolute
  import { inject } from "vue";

  const { changeIndex, indexNow, checkChangeIndexValid } = inject("passiveScrollHandler") as usePassiveScroll.passiveScrollHandler;

  const props = defineProps<{
    to: string
  }>();

  function toNext(){
    const next = document.createElement('a');
    if(checkChangeIndexValid(indexNow, true)){
      changeIndex(indexNow + 1);
      next.href = props.to;
      next.click();
    }
  }
</script>

<template>
  <el-icon class="three-next" @click="toNext">
    <ArrowDown />
  </el-icon>
</template>

<style scoped>
  @keyframes jump-arrow {
    0%{
      transform: translate(-50%, 0);
    }
    15%{
      transform: translate(-50%, -2vh);
    }
    40%, 70%{
      transform: translate(-50%, 2vh);
    }
    90%{
      transform: translate(-50%, -1vh);
    }
    100%{
      transform: translate(-50%, 0);
    }
  }

  .three-next{
    position: absolute;
    bottom: 4vh;
    left: 50%;
    color: var(--font-main-color);
    font-size: max(2.5rem, 4vw);
    cursor: pointer;
    animation: jump-arrow 2s infinite linear;
    transition: all .3s;
    z-index: 90;
  }

  .three-next:hover{
    color: var(--hover-color);
  }
</style>
