<template>
  <el-container class="layout-container-demo" style="height: 500px">
    <el-header style=" font-size: 40px ;background-color: rgb(238, 241, 246)">Java&nbsp;Web</el-header>
    <el-container>
      <el-aside width="220px">
        <el-scrollbar>
          <el-menu :default-openeds="['1', '2']">
            <el-sub-menu index="1">
              <template #title>
                <el-icon>
                  <HomeFilled />
                </el-icon>平时作业
              </template>
              <el-menu-item-group>
                <template #title>第二章</template>
                <el-menu-item index="2-1">
                  <router-link to="/assignments/calculate">计算面积</router-link>
                </el-menu-item>
              </el-menu-item-group>
              <el-menu-item-group title="第四章">
                <el-menu-item index="4-1">
                  <router-link to="/assignments/form">form表单</router-link>
                </el-menu-item>
                <el-menu-item index="4-2">
                  <router-link to="/assignments/experience">实验</router-link>
                </el-menu-item>
              </el-menu-item-group>
              <el-menu-item-group title="第五章">
                <el-menu-item index="5-1">
                  <router-link to="/assignments/area">梯形面积</router-link>
                </el-menu-item>
              </el-menu-item-group>
            </el-sub-menu>
            <el-sub-menu index="3">
              <template #title>
                <el-icon>
                  <UserFilled />
                </el-icon>大作业
              </template>
              <el-menu-item-group>
                <template slot="title">登录</template>
                <el-menu-item index="2-1">
                  <router-link to="/userLogin">学生登录</router-link>
                </el-menu-item>
              </el-menu-item-group>
            </el-sub-menu>
          </el-menu>
        </el-scrollbar>
      </el-aside>
      <el-main>
        <router-view></router-view>
      </el-main>
    </el-container>
  </el-container>
</template>

<script lang="ts" setup>

</script>

<style scoped>
a {
  text-decoration: none;
  color: #303133;
}

.router-link-active {
  text-decoration: none;
  color: #409EFF;
}

.layout-container-demo .el-header {
  position: relative;
  background-color: var(--el-color-primary-light-7);
  color: var(--el-text-color-primary);
}

.layout-container-demo .el-aside {
  color: var(--el-text-color-primary);
  background: var(--el-color-primary-text);
}

.layout-container-demo .el-menu {
  border-right: none;
}

.layout-container-demo .el-main {
  padding: 0;
}

.layout-container-demo .toolbar {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  height: 100%;
  right: 20px;
}
</style>