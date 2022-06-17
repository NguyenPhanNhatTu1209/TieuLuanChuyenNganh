import { ApiMethods, ApiRoutes } from "../defineApi";
import Repository from "../RepositoryApi";
import { ReturnResponse } from "../Response";

export interface payloadCreatOrder {
  cartId: Array<string>;
  area: {
    name: string;
    phone: string;
    province: string;
    district: string;
    address: string;
  };
  note: string;
  typePaymentOrder: number;
}
const route: ApiRoutes = {
  method: ApiMethods.POST, //GET,DELETE su dung param
  // POST, PUT, PATCH su dung payload
  url: "order/createOrder",
};
export const createOrderAsync = async (
  payload: payloadCreatOrder
): Promise<ReturnResponse<any>> => {
  return Repository(route, payload);
};
