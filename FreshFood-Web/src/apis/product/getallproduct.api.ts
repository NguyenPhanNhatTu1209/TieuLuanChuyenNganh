import { ApiMethods, ApiRoutes } from "../defineApi";
import Repository from "../RepositoryApi";
import { ReturnListResponse } from "../Response";

export interface payloadGetAllProduct {
  limit: number;
  skip: number;
  groupProduct?: string;
}

const route: ApiRoutes = {
  method: ApiMethods.GET, //GET,DELETE su dung param
  // POST, PUT, PATCH su dung payload
  url: "product/findAllProduct",
};
export const getAllProductApi = async (
  payload: payloadGetAllProduct
): Promise<ReturnListResponse<any>> => {
  return Repository(route, payload);
};
