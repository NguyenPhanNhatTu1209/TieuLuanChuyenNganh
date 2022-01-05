import { ApiMethods, ApiRoutes } from "../defineApi";
import Repository from "../RepositoryApi";
import { ReturnResponse } from "../Response";

interface payloadCreatecart {
  productId: string;
  quantity: number;
}
const route: ApiRoutes = {
  method: ApiMethods.POST, //GET,DELETE su dung param
  // POST, PUT, PATCH su dung payload
  url: "cart/createCart",
};
export const createCartAsync = async (
  payload: payloadCreatecart
): Promise<ReturnResponse<any>> => {
  return Repository(route, payload);
};
