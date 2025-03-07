import axios from "axios";
import { useAuthStore } from "./authStore";

// const authStore = useAuthStore();

const axiosInstance = axios.create(
    {
        baseURL: 'http://127.0.0.1:8000/api/',
        headers: {
            'Accept': 'application/json',
            'Content-Type': 'multipart/form-data',

        }
    }
);
// Intercepteur pour insérer le token avant chaque requête
axiosInstance.interceptors.request.use(
    (config) => {
        const authStore = useAuthStore();
        if (authStore.token) {
            config.headers.Authorization = `Bearer ${authStore.token}`;
        }
        return config;
    },
    (error) => Promise.reject(error)
);

export default function useApi(){
    const $get = (url, params :{} = {}) =>{
        return axiosInstance.get(url, params).then(response => {
            console.log(response)
            return response.data;
        })
    }
    const $post = (url, data: {} = {}) => {
        return axiosInstance.post(url, data).then(response => response.data)
    }

    const $put = (url, data: {} = {}) => {
        return axiosInstance.put(url, data).then(response => {
            console.log(response)
            return response.data;
        })
    }
    const $delete = (url, data: {} = {}) => {
        return axiosInstance.delete(url, data).then(response => response.data)
    }
    return {
        $get,
        $post,
        $put,
        $delete
    }
}
