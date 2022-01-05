import { ApiMethods, ApiRoutes } from "../defineApi";
import Repository from "../RepositoryApi";
import { ReturnListResponse } from "../Response";

export interface payloadGetOrderByUser {
  skip: number;
  limit: number;
  status: number;
}

const route: ApiRoutes = {
  method: ApiMethods.GET, //GET,DELETE su dung param
  // POST, PUT, PATCH su dung payload
  url: "order/getOrders",
};
export const getGetOrderByUserApi = async (
  payload: payloadGetOrderByUser
): Promise<ReturnListResponse<any>> => {
  return Repository(route, payload);
};
