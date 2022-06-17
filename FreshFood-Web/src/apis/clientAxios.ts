/* eslint-disable no-console */
import axios, { AxiosRequestConfig, AxiosResponse } from 'axios';
import queryString from 'query-string';
const axiosClient = axios.create({
	baseURL: 'http://18.140.53.176:3005',
	timeout: 20000,
	headers: {
		'Content-Type': 'application/json',
		'Access-Control-Allow-Origin': '*',
	},
	paramsSerializer: (params) => {
		return queryString.stringify(params);
	},
});

axiosClient.interceptors.request.use(
	(config: any) => {
		// console.log(
		//     `LHA:  ===> file: clientAxios.ts ===> line 18 ===> config`,
		//     config
		// );
		const token = localStorage.getItem('token');
		if (token) config.headers.authorization = `Bearer ${token}`;
		return config;
	},
	(err) => {
		console.log(err.response);

		return Promise.reject(err);
	}
);
axiosClient.interceptors.response.use(
	(res: AxiosResponse) => {
		if (res && res.data) return res.data;
		return res;
	},
	(err) => {
		console.log(err.response);
		if (err.response && err.response.data) return err.response.data;
		return Promise.reject(err);
	}
);

export default axiosClient;
