import axiosClient from './clientAxios';
import { ApiMethods, ApiRoutes } from './defineApi';
const Repository = async (
	route: ApiRoutes,
	payload: any = {},
	optional: Record<string, unknown> = {}
): Promise<any> => {
	switch (route.method) {
		case ApiMethods.GET:
			return await axiosClient.get(route.url, {
				params: payload,
			});
		case ApiMethods.POST:
			return await axiosClient.post(route.url, payload);
		case ApiMethods.PUT:
			return await axiosClient.put(route.url, payload);
		case ApiMethods.DELETE:
			return await axiosClient.delete(route.url, {
				params: payload,
			});
		default:
			break;
	}
};
export default Repository;
