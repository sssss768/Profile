<template>
    <el-form ref="FormRef" style="max-width: 600px" :model="Form" status-icon :rules="rules" label-width="auto"
        class="Form">
        <el-form-item label="用户名">
            <el-input v-model="Form.name" />
        </el-form-item>
        <el-form-item prop="email" label="邮箱地址" :rules="[
            {
                required: true,
                message: '请输入邮箱地址',
                trigger: 'blur',
            },
            {
                type: 'email',
                message: '请输入正确的邮箱地址',
                trigger: ['blur', 'change'],
            },
        ]">
            <el-input v-model="Form.email" />
        </el-form-item>
        <el-form-item label="设置密码" prop="pass">
            <el-input v-model="Form.pass" type="password" autocomplete="off" />
        </el-form-item>
        <el-form-item label="确认密码" prop="checkPass">
            <el-input v-model="Form.checkPass" type="password" autocomplete="off" />
        </el-form-item>
        <el-form-item label="真实姓名">
            <el-input v-model="Form.realName" />
        </el-form-item>
        <el-form-item label="性别">
            <el-select v-model="Form.sex" placeholder="请选择" size="large" style="width: 150px;">
                <el-option label="男" value="male"></el-option>
                <el-option label="女" value="female"></el-option>
            </el-select>
        </el-form-item>
        <el-form-item>
            &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
            <el-upload class="upload-demo" :http-request="httpRequest" :before-upload="beforeUpload"
                :before-remove="beforeRemove" :limit="1">
                <el-button type="primary">上传头像</el-button>
                <template #tip>
                    <div class="el-upload__tip">
                    </div>
                </template>
            </el-upload>
        </el-form-item>
        <el-form-item>
            <br>&emsp;&emsp;&emsp;
            <el-button type="primary" @click="submitForm(FormRef)">
                提交
            </el-button>
            <el-button @click="resetForm(FormRef)">重置</el-button>
        </el-form-item>
    </el-form>
</template>

<script lang="ts" setup>
import { reactive, ref } from 'vue'
import type { FormInstance, FormRules, ElMessageBox } from 'element-plus'
import type { UploadProps, UploadUserFile } from 'element-plus'
import axios from 'axios';
import router from '../../router';
import { type UserForm } from '@/types/user.ts';

const FormRef = ref<FormInstance>()

const validatePass = (rule: any, value: any, callback: any) => {
    if (value === '') {
        callback(new Error('请输入密码'))
    } else {
        if (Form.checkPass !== '') {
            if (!FormRef.value) return
            FormRef.value.validateField('checkPass')
        }
        callback()
    }
}
const validatePass2 = (rule: any, value: any, callback: any) => {
    if (value === '') {
        callback(new Error('请再次输入密码'))
    } else if (value !== Form.pass) {
        callback(new Error('两次输入密码不一致!'))
    } else {
        callback()
    }
}

const Form = reactive<UserForm>({
    name: '',
    email: '',
    pass: '',
    checkPass: '',
    realName: '',
    sex: '',
    fileList: [] as File[],
})

const rules = reactive<FormRules<typeof Form>>({
    pass: [{ validator: validatePass, trigger: 'blur' }],
    checkPass: [{ validator: validatePass2, trigger: 'blur' }],
})

const submitForm = async (formEl: FormInstance | undefined) => {
    if (!formEl) return
    formEl.validate(async (valid) => {
        if (valid) {
            console.log('Valid form data:', Form);

            const formData = new FormData();
            formData.append('name', Form.name);
            formData.append('email', Form.email);
            formData.append('pass', Form.pass);
            formData.append('realName', Form.realName);
            formData.append('sex', Form.sex);

            Form.fileList.forEach((file: any) => {
                formData.append('img', file);
            });
            console.log("提交", formData)
            try {
                const res = await axios.post('/api/login/register', formData, {
                    headers: {
                        'Content-Type': 'multipart/form-data',
                    },
                });
                console.log('Form submitted successfully:', res.data);
                if (res.data.code === 1) {
                    router.push({
                        path: '/assignments/submit',
                        state: { data: res.data.data }, 
                    });
                } else {
                    console.error('后端返回错误:', res.data.msg);
                }
            } catch (error) {
                console.error('Error submitting form:', error);
            }
        } else {
            console.log('error submit!');
        }
    })
}

const resetForm = (formEl: FormInstance | undefined) => {
    if (!formEl) return
    formEl.resetFields()
}


const beforeUpload = (file: File) => {
    console.log("文件准备上传：", file.name);
    return true;
};

const beforeRemove: UploadProps['beforeRemove'] = (uploadFile, uploadFiles) => {
    return ElMessageBox.confirm(
        `Cancel the transfer of ${uploadFile.name} ?`
    ).then(
        () => true,
        () => false
    )
}

const httpRequest = async (option: any) => {
    Form.fileList.push(option.file)
    console.log(Form.fileList[0])
}
</script>

<style scoped>
.el-input {
    width: 150px;
    height: 40px;
}
</style>