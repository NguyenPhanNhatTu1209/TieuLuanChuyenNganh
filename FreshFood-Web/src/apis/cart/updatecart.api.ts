import { ApiMethods, ApiRoutes } from "../defineApi";
import Repository from "../RepositoryApi";
import { ReturnListResponse } from "../Response";

interface payloadUpdateCart {
  id: string;
  quantity: number;
  status: number;
}
const route: ApiRoutes = {
  method: ApiMethods.PUT, //GET,DELETE su dung param
  // POST, PUT, PATCH su dung payload
  url: "cart/updateCart",
};
export const updateCartAsync = async (
  payload: Array<payloadUpdateCart>
): Promise<ReturnListResponse<any>> => {
  return Repository(route, payload);
};
