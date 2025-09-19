<template>
    <div class="index-contract-container" ref="baseContainer">
        <div class="title-container">
            <div class="title">
                &lt; {{ '家乡文化' }} >
            </div>
        </div>


        <div v-if="isShow" class="contract-container" ref="contractContainer">
            <div class="contract-title">
                <div class="contract-title-msg">
                    - {{ '文化信息' }} -</div>
                <div v-for="fit in fits" :key="fit" class="demo-fit">
                    <span class="title">{{ fit }}</span>
                    <el-avatar shape="square" :size="100" :fit="fit" :src="food?.img" />
                </div>
            </div>
            <div class="contract-item">
                <el-scrollbar>
                    <div class="contract-item-scroll">
                        <span class="contract-item-scroll-name">文化名称：</span>
                        <input v-if="food" type="text" class="contract-item-scroll-input" v-model="food.name" />

                    </div>
                    <div class="contract-item-scroll">
                        <span class="contract-item-scroll-name">文化地址：</span>
                        <input v-if="food" type="text" class="contract-item-scroll-input" v-model="food.material" />
                    </div>
                    <div class="contract-item-scroll">
                        <span class="contract-item-scroll-name">文化描述：</span>
                        <el-input v-if="food" style="width: 380px" :rows="2" type="textarea" class="contract-item-text"
                            placeholder="Description" v-model="food.description" />
                    </div>

                </el-scrollbar>
            </div>
            <div class="contract-item-scroll">
                <button class="contract-item-scroll-button" @click="updateFood">
                    提交修改
                </button>
                <button class="contract-item-scroll-button" @click="deleteFood">
                    删除文化
                </button>
                <el-upload class="contract-item-scroll-button" :http-request="httpRequest" :before-upload="beforeUpload"
                    :on-remove="handleRemove" :limit="1">
                    <el-button type="primary" class="register-edit">修改图像</el-button>
                    <template #tip>
                        <div class="el-upload__tip">
                        </div>
                    </template>
                </el-upload>
            </div>
        </div>
        <div v-else class="contract-container" ref="contractContainer">
            <div class="contract-title">
                <div class="contract-title-msg">
                    - {{ '添加文化' }} -</div>
            </div>
            <div class="contract-item">
                <el-scrollbar>
                    <div class="contract-item-scroll">
                        <span class="contract-item-scroll-name">文化名称：</span>
                        <input v-if="food" type="text" class="contract-item-scroll-input" v-model="food.name" />

                    </div>
                    <div class="contract-item-scroll">
                        <span class="contract-item-scroll-name">文化地址：</span>
                        <input v-if="food" type="text" class="contract-item-scroll-input" v-model="food.material" />
                    </div>
                    <div class="contract-item-scroll">
                        <span class="contract-item-scroll-name">文化描述：</span>
                        <el-input v-if="food" style="width: 380px" :rows="2" type="textarea" class="contract-item-text"
                            placeholder="Description" v-model="food.description" />
                    </div>

                </el-scrollbar>
            </div>
            <div class="contract-item-scroll">
                <button class="contract-item-scroll-button" @click="addFood">
                    添加文化
                </button>
                <el-upload class="contract-item-scroll-button" :http-request="httpRequest" :before-upload="beforeUpload"
                    :on-remove="handleRemove" :limit="1">
                    <el-button type="primary" class="register-edit">上传图像</el-button>
                    <template #tip>
                        <div class="el-upload__tip">
                        </div>
                    </template>
                </el-upload>
            </div>
        </div>



        <div class="canvas-container" ref="canvasContainer">
            <el-container>
                <el-header>
                    <div class="canvas-item-header">

                        <el-input placeholder="Search" v-model="search"></el-input>
                        <el-button class="canvas-item-header-icon" @click="searchFood" :icon="Search" />
                    </div>
                </el-header>
                <el-main>
                    <div v-if="food" class="canvas-item" :key="foods.length">
                        <el-scrollbar class="canvas-scrollbar">
                            <div v-for="item in foods" :key="item.email" class="scrollbar-demo-item">
                                <el-button class="canvas-item-scroll" @click="routeToCard(item)">
                                    <span class="canvas-item-scroll-name">{{ item.name }}</span>
                                </el-button>
                            </div>
                        </el-scrollbar>
                    </div>
                    <button class="canvas-item-scroll-button" @click="switchFood">
                        新增/查看
                    </button>
                </el-main>
            </el-container>
        </div>

    </div>
</template>

<script setup lang="ts">
import { ref, onMounted, onBeforeUnmount } from "vue";
import threeD2 from "./three/threeD2";
import useVisible from "@/utils/useVisible.ts";
import type { User } from "../../../types/user";
import axiosInstance from "../../../utils/Axios";
import type { UploadProps } from 'element-plus'
import { Search } from "@element-plus/icons-vue";
import { reactive, toRefs } from 'vue'
import type { ObjectFitProperty } from 'csstype'
import { type Food } from "../../../types/food";

let isShow = true;
const canvasContainer = ref<HTMLElement | null>(null);
const contractContainer = ref<HTMLElement | null>(null);
const state = reactive({
    fits: [
        'fill',
    ] as ObjectFitProperty[],
    url: "http://localhost:8080/img/users/imageERROR.jpg.bmp",
})
const { fits, url } = toRefs(state)



const props = defineProps<{
    user: User | null;
}>();
if (!props.user) {
    alert("不存在文化");
    window.location.href = '/userLogin';
}

// 
const user = ref(props.user);
let foods = <Food[]>[];
const food = ref<Food | null>(null);
const search = ref(null)
const fetchFoods = async () => {
    try {
        const formData = new FormData();
        formData.append('email', user.value.email);
        const response = await axiosInstance.get('/api/cultures', {
            data: formData,
            headers: {
                'Content-Type': 'multipart/form-data',
            },
        });

        console.log("fileList", fileList)
        if (response.data.code === 1) {
            foods = response.data.data;
            food.value = foods[0]
            console.log(foods)
        } else {
            console.error('后端错误:', response.data.msg);
        }
    } catch (error) {
        console.error('无法获取cultures:', error);
    }
}
onMounted(fetchFoods)



// 文件上传
const fileList: File[] = [];
const beforeUpload = (file: File) => {
    console.log("文件准备上传：", file.name);
    return true;
};
const handleRemove: UploadProps['onRemove'] = (file, uploadFiles) => {
    console.log(file, uploadFiles)
}
const httpRequest = async (option: any) => {
    fileList.push(option.file)
    console.log(fileList[0])
}


const updateFood = async () => {
    try {
        console.log("提交", food)
        const formData = new FormData();
        formData.append('email', food.value.email);
        formData.append('name', food.value.name);
        formData.append('address', food.value.material);
        formData.append('description', food.value.description);
        if (fileList.length > 0) {
            fileList.forEach((file: any) => {
                formData.append('image', file);
            });
        } else {
            formData.append('image', new File([], ''));
        }
        const response = await axiosInstance.put('/api/cultures', formData,{
            headers: {
                'Content-Type': 'multipart/form-data',
            },
        });


        if (response.data.code === 1) {
            alert("修改成功！")
            food.value.img = response.data.data.img
        } else {
            console.error('后端错误:', response.data.msg);
        }
    } catch (error) {
        console.error('无法获取scenery:', error);
    }
}
const addFood = async () => {
    try {
        console.log("提交", food)
        const formData = new FormData();
        formData.append('email', food.value.email);
        formData.append('name', food.value.name);
        formData.append('address', food.value.material);
        formData.append('description', food.value.description);
        if (fileList.length > 0) {
            fileList.forEach((file: any) => {
                formData.append('image', file);
            });
        } else {
            formData.append('image', new File([], ''));
        }
        const response = await axiosInstance.post('/api/cultures', formData, {
            headers: {
                'Content-Type': 'multipart/form-data',
            },
        });


        if (response.data.code === 1) {
            alert("添加成功！")
            fetchFoods();

        } else {
            console.error('后端错误:', response.data.msg);
        }
        isShow = true;
    } catch (error) {
        console.error('添加失败:', error);
    }
}


const deleteFood = async () => {
    try {
        console.log("删除", food.value.name, food.value.email)
        const formData = new FormData();
        formData.append('email', food.value.email);
        formData.append('name', food.value.name);
        const response = await axiosInstance.delete('/api/cultures', {
            data: formData,
            headers: {
                'Content-Type': 'multipart/form-data',
            },
        });



        if (response.data.code === 1) {
            alert("删除成功！")
            fetchFoods()
        } else {
            console.error('后端错误:', response.data.msg);
        }
    } catch (error) {
        console.error('无法获取cultures:', error);
    }
}
const searchFood = async () => {
    try {
        console.log("email,name", user.value.email, search.value)
        const formData = new FormData();
        formData.append('email', user.value.email);
        formData.append('name', search.value);
        const response = await axiosInstance.get('/api/cultures', {
            params: {
                email: user.value.email,
                name: search.value,
            },
            headers: {
                'Content-Type': 'multipart/form-data',
            }
        });
        if (response.data.code === 1) {
            foods = response.data.data;
            food.value = foods[0]
            console.log(foods)
        } else {
            console.error('后端错误:', response.data.msg);
        }
    } catch (error) {
        console.error('无法查找cultures:', error);
    }
}
const routeToCard = (item: Food) => {
    const selectedFood = foods.find(food => food.name === item.name);

    if (selectedFood) {
      
        food.value = selectedFood;  
        console.log('选中的文化:', selectedFood);
    } else {
        console.error('未找到对应的文化');
    }
};
const switchFood = () => {
    if (isShow) {
        isShow = !isShow;
        food.value = {
            name: '',
            material: '',
            description: '',
            img: '',
            email: user.value.email, 
        };
    } else {
        isShow = !isShow;
        food.value = foods[0]
    }
    useVisible(contractContainer, {
        onIntersect: () => {
            contractContainer.value?.classList.add("show-ani");
            if (window.innerWidth >= 768) {
                // 加载模型，实现类似懒加载的效果
                threeD2.needRender = true;
                // doInitModel();
            }
        },
    });
};


// 处理大小问题
let timer: null | number = null;
const handleResize = () => {
    if (timer) {
        clearTimeout(timer);
    }
    timer = window.setTimeout(() => {
        if (window.innerWidth >= 768) {
            threeD2.needRender = true;
        } else {
            threeD2.needRender = false;
        }
    }, 80);
};


// 添加进入可视区域的处理
useVisible(contractContainer, {
    onIntersect: () => {
        contractContainer.value?.classList.add("show-ani");
        if (window.innerWidth >= 768) {
            // 加载模型，实现类似懒加载的效果
            threeD2.needRender = true;
            // doInitModel();
        }
    },
});

onMounted(() => {
    window.addEventListener("resize", handleResize);
});

onBeforeUnmount(() => {
    window.removeEventListener("resize", handleResize);
});


const baseContainer = ref<HTMLElement | null>(null);

</script>

<style scoped>
.demo-fit {
    display: flex;
    text-align: center;
    justify-content: space-between;
    margin-left: 30%;
    margin-top: 2%;
}

.demo-fit .block {
    flex: 1;
    display: flex;
    flex-direction: column;
    flex-grow: 0;
}

.demo-fit .title {
    margin-bottom: 10px;
    font-size: 14px;
    color: var(--el-text-color-secondary);
}

.canvas-item-header {
    display: flex;
    align-items: center;
}


.canvas-item-header .el-input {
    color: var(--font-main-color);
    transition: all 0.3s;
    border-color: #ffffff;
    background-color: #FFFFFF;
    font-size: max(1vw, 0.8rem);
    font-size: ;
    width: 80%;
    height: 6vh;
}

.canvas-item-header-icon {
    color: #A3A6AD;
    font-size: 3vh;
    align-items: right;
    width: 20%;
    height: 6vh;
    background-color: #ffffff;
    border-color: #ffffff;
}

.canvas-item-header-icon:hover {
    color: #A3A6AD;
    font-size: 3vh;
    align-items: right;
    width: 20%;
    height: 6vh;
    background-color: #ffffff;
    border-color: #ffffff;
}

.canvas-item-header :deep(.el-input__wrapper) {
    box-shadow: 0 0 0 0px var(--el-input-border-color, var(--el-border-color)) inset;
    cursor: default;

    .el-input__inner {
        cursor: default !important;
    }
}


.search-icon:hover {
    background-color: var(--font-main-color);
    color: var(--overall-background-color);
}

.el-header {
    border-bottom: 1px solid var(--solid-color);
}

.upload-demo {
    display: flex;
    align-items: center;
    justify-content: flex-start;
    gap: 0px;

    .el-upload-list__item-info {
        color: rgb(78, 78, 82);
        width: 150px
    }

}

.contract-scrollbar {
    width: 100%;
}

.canvas-scrollbar {
    display: flex;
    align-items: center;
    justify-content: center;
    height: 400px;
    margin: 10px;
    text-align: center;
    border-radius: 4px;
    color: var(--el-color-primary);
}

@keyframes show-up {
    0% {
        opacity: 0;
        transform: translateY(-3vh);
        box-shadow: none;
    }

    100% {
        opacity: 1;
        transform: translateY(0);
        box-shadow: 0px 0px 3vh var(--color-box-shadow);
    }
}

.show-ani {
    animation: show-up 1.2s ease-out 1 forwards;
}

.index-contract-container {
    position: relative;
    display: flex;
    justify-content: space-around;
    align-items: center;
    flex-wrap: wrap;
    align-content: space-around;
    width: 100%;
    height: 90vh;
    background-color: transparent;
}

.title-container {
    margin-right: -100px;
    width: 45vw;
    height: 80vh;
    display: flex;
    justify-content: center;
    align-items: center;
    border-radius: 10%;
    color: var(--font-main-color);
    font-weight: 300;
    font-size: max(2vw, 1rem);
    display: none;
    width: 70vw;
    height: 10vh;
}

.canvas-container {
    margin-left: -15vh;
    width: 25vw;
    height: 80vh;
    display: flex;
    justify-content: center;
    align-items: center;
    border-radius: 5%;
    color: var(--font-main-color);
    font-weight: 300;
    font-size: max(2vw, 1rem);
}

.contract-container {
    display: flex;
    justify-content: center;
    flex-wrap: wrap;
    align-content: space-around;
    opacity: 0;
    width: 45vw;
    height: 80vh;
    border: 1px solid var(--color-box-shadow);
    border-radius: 10%;
}

.contract-title-msg {
    height: 50%;
    margin-top: 6%;
    margin-left: 18%;
}

.contract-title {
    display: flex;
    width: 100%;
    text-align: center;
    font-size: max(1.5vw, 1.5rem);
    font-weight: 300;
    color: var(--font-main-color);
    user-select: none;
}

.canvas-title {
    width: 30%;
    text-align: center;
    font-size: max(1.5vw, 1.5rem);
    font-weight: 300;
    color: var(--font-main-color);
    user-select: none;
}


.canvas-item {
    width: 100%;
    height: 70%;
    justify-content: center;
    align-items: center;
}

.contract-item {
    width: 100%;
    height: 70%;
    justify-content: center;
    align-items: center;
}

.contract-item-text {
    display: flex;
    border-radius: 4px;
    width: 100px;
    margin-top: 30px;
    height: 50px;
}


.contract-item-scroll {
    display: flex;
    border-radius: 4px;
    width: 100%;
    margin-top: 30px;
    height: 50px;
    justify-content: center;
    align-items: center;
}

.canvas-item-scroll:hover {
    border-color: #3C3C4377;
}

.canvas-item-scroll {
    color: #A3A6AD;
    background-color: #ffffff;
    display: flex;
    border-radius: 4px;
    width: 340px;
    margin-bottom: 20px;
    height: 80px;
    justify-content: center;
    align-items: center;
}

.contract-item-scroll-name {
    text-align: right;
    color: var(--font-main-color);
    font-size: max(1.1vw, 0.8rem);
    font-weight: 300;
    margin-right: 1vw;
    user-select: none;
}

.canvas-item-scroll-name {
    text-align: right;
    color: var(--font-main-color);
    font-size: max(1.1vw, 0.8rem);
    font-weight: 300;
    margin-right: 1vw;
    user-select: none;
}

.canvas-item-scroll-input {
    position: relative;
    width: 50%;
    border: none;
    outline: none;
    padding-left: 3px;
    padding-bottom: 3px;
    color: var(--font-main-color);
    font-size: max(1vw, 0.8rem);
    font-weight: 300;
    background-color: transparent;
    transition: all 0.3s;
}

.contract-item-scroll-input {
    position: relative;
    width: 50%;
    border: none;
    outline: none;
    border-bottom: 1px solid var(--solid-color);
    padding-left: 3px;
    padding-bottom: 3px;
    color: var(--font-main-color);
    font-size: max(1vw, 0.8rem);
    font-weight: 300;
    background-color: transparent;
    transition: all 0.3s;
}

.contract-item-scroll-input:hover,
.contract-item-scroll-input:focus {
    border-bottom: 1px solid var(--font-main-color);
}

.contract-item-scroll-button {
    width: 20%;
    height: 5vh;
    background-color: var(--overall-background-color);
    border: 1px solid var(--font-main-color);
    border-radius: 10px;
    color: var(--font-main-color);
    font-weight: 300;
    font-size: max(1vw, 0.8rem);
    cursor: pointer;
    margin: 3%;
    margin-bottom: 8%;
}

.register-edit {
    width: 70px;
    height: 38px;
    background-color: transparent;
    border: transparent;
    border-radius: 10px;
    color: var(--font-main-color);
    font-weight: 300;
    font-size: max(1vw, 0.8rem);
    cursor: pointer;
    transition: all 0.3s;
    margin-left: 40px;

}

.register-edit:hover {
    color: #FFFFFF;
}

.contract-item-scroll-button {
    width: 20%;
    height: 5vh;
    background-color: var(--overall-background-color);
    border: 1px solid var(--font-main-color);
    border-radius: 10px;
    color: var(--font-main-color);
    font-weight: 300;
    font-size: max(1vw, 0.8rem);
    cursor: pointer;
    transition: all 0.3s;
    margin: 3%;
    margin-bottom: 8%;
}

.canvas-item-scroll-button {
    width: 38%;
    height: 5vh;
    background-color: var(--overall-background-color);
    border: 1px solid var(--font-main-color);
    border-radius: 10px;
    color: var(--font-main-color);
    font-weight: 300;
    font-size: max(1vw, 0.8rem);
    cursor: pointer;
    margin-left: 8%;
    margin-top: 15%;
}

.contract-item-scroll-button:hover {
    background-color: var(--font-main-color);
    color: var(--overall-background-color);
}

.canvas-item-scroll-button:hover {
    background-color: var(--font-main-color);
    color: var(--overall-background-color);
}


.canvas-content {
    user-select: none;
}

.title {
    display: none;
}

@media screen and (max-width: 1000px) {

    .canvas-container,
    .contract-container {
        border-radius: 20px;
    }
}

@media screen and (max-width: 768px) {
    .canvas-container {
        width: 70vw;
        height: 10vh;
    }

    .contract-container {
        width: 90vw;
        height: 70vh;
    }

    .canvas-content {
        display: none;
    }

    .title {
        display: block;
    }

    .contract-title {
        display: none;
    }

    .title-container {
        display: flex;
        border-radius: 20px;
        border: 1px solid var(--color-box-shadow);
        box-shadow: 0px 0px 3vh var(--color-box-shadow);
    }

}
</style>
