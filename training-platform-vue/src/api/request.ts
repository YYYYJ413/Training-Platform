import axios from 'axios';
import router from '../router';

const BASE_URL = 'http://localhost:8081';



const instance = axios.create({
    baseURL: BASE_URL,
    timeout: 5000,
    withCredentials: true, // 允许跨域
    headers: {
        'Content-Type': 'application/json;charset=UTF-8'
    }
});

export default instance;

axios.interceptors.response.use(
    (response) => {
        if (response.status === 200) {
            return Promise.resolve(response);
        } else {
            return Promise.reject(response);
        }
    },
    (error) => {
        if (error.response) {
            switch (error.response.status) {
                case 401:
                    router.replace({
                        path: "/",
                    });
                    break;
                case 403:
                    setTimeout(() => {
                        router.replace({
                            path: '/',
                        })
                    }, 1000);
                case 404:
                    break;
            }
            return Promise.reject(error.response);
        }
    }
);

export function getBaseURL() {
    return BASE_URL;
}

/**
 * 封装get方法
 * @param url
 * @param data
 * @returns {Promise}
 */
export function get(url, params?: object) {
    return new Promise((resolve, reject) => {
        axios.get(url, params).then(
            (response) => resolve(response.data),
            (error) => reject(error)
        );
    });
}

/**
 * 封装post请求
 * @param url
 * @param data
 * @returns {Promise}
 */
export function post(url, data = {}) {
    return new Promise((resolve, reject) => {
        axios.post(url, data).then(
            (response) => resolve(response.data),
            (error) => reject(error)
        );
    });
}

/**
 * 封装delete请求
 * @param url
 * @param data
 * @returns {Promise}
 */
export function deletes(url, data = {}) {
    return new Promise((resolve, reject) => {
        axios.delete(url, data).then(
            (response) => resolve(response.data),
            (error) => reject(error)
        );
    });
}

/**
 * 封装put请求
 * @param url
 * @param data
 * @returns {Promise}
 */
export function put(url, data = {}) {
    return new Promise((resolve, reject) => {
        axios.put(url, data).then(
            (response) => resolve(response.data),
            (error) => reject(error)
        );
    });
}
