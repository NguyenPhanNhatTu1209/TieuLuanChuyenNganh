import { ApiMethods, ApiRoutes } from "../defineApi";
import Repository from "../RepositoryApi";
import { ReturnResponse } from "../Response";

interface payloadGetDetailProduct {
  id: string;
}

const route: ApiRoutes = {
  method: ApiMethods.GET, //GET,DELETE su dung param
  // POST, PUT, PATCH su dung payload
  url: "product/getDetailProduct",
};
export const getDetailProductApi = async (
  payload: payloadGetDetailProduct
): Promise<ReturnResponse<any>> => {
  return Repository(route, payload);
};
