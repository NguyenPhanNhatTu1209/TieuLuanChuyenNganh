import { ApiMethods, ApiRoutes } from "../defineApi";
import Repository from "../RepositoryApi";
import { ReturnResponse } from "../Response";

interface payloadDeleteCart {
  id: string;
}

const route: ApiRoutes = {
  method: ApiMethods.DELETE, //GET,DELETE su dung param
  // POST, PUT, PATCH su dung payload
  url: "cart/deleteCart",
};
export const deleteCartAsync = async (
  payload: payloadDeleteCart
): Promise<ReturnResponse<any>> => {
  return Repository(route, payload);
};
