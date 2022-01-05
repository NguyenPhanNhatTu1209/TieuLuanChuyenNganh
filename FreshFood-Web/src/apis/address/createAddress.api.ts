import { ApiMethods, ApiRoutes } from "../defineApi";
import Repository from "../RepositoryApi";
import { ReturnResponse } from "../Response";

export interface payloadCreateAddress {
  name: string;
  phone: string;
  province: string;
  district: string;
  address: string;
  isMain: boolean;
}
const route: ApiRoutes = {
  method: ApiMethods.POST, //GET,DELETE su dung param
  // POST, PUT, PATCH su dung payload
  url: "address/createAddress",
};
export const createAddressAsync = async (
  payload: payloadCreateAddress
): Promise<ReturnResponse<any>> => {
  return Repository(route, payload);
};
