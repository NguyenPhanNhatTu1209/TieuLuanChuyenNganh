import { ApiMethods, ApiRoutes } from "../defineApi";
import Repository from "../RepositoryApi";
import { ReturnListResponse } from "../Response";

export interface payloadGetAllOrder {
  skip: number;
  limit: number;
  status: number;
}

const route: ApiRoutes = {
  method: ApiMethods.GET, //GET,DELETE su dung param
  // POST, PUT, PATCH su dung payload
  url: "order/getOrdersByAdmin",
};
export const getGetAllOrderApi = async (
  payload: payloadGetAllOrder
): Promise<ReturnListResponse<any>> => {
  return Repository(route, payload);
};
