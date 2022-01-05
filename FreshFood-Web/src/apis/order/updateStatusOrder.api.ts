import { ApiMethods, ApiRoutes } from "../defineApi";
import Repository from "../RepositoryApi";
import { ReturnResponse } from "../Response";

export interface payloadUpdateStatusOrder {
  id: string;
  status: number;
}
const route: ApiRoutes = {
  method: ApiMethods.PUT, //GET,DELETE su dung param
  // POST, PUT, PATCH su dung payload
  url: "order/updateStatusOrder",
};
export const updateStatusOrderApi = async (
  payload: payloadUpdateStatusOrder
): Promise<ReturnResponse<any>> => {
  return Repository(route, payload);
};
