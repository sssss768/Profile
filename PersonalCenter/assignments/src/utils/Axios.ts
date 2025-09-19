import axios from 'axios';

// 创建axios实例
const axiosInstance = axios.create();

axiosInstance.interceptors.request.use(
    (config) => {
        const token = localStorage.getItem('token');
        if (token) {
            Object.assign(config.headers, { 'token': token });
        }
        return config;
    },
    (error) => {

        return Promise.reject(error);
    }
);


export default axiosInstance;