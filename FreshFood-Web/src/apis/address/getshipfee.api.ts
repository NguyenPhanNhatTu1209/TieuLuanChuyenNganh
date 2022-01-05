import { ApiMethods, ApiRoutes } from "../defineApi";
import Repository from "../RepositoryApi";
import { ReturnResponse } from "../Response";

interface payloadGetShipFee {
  province: string;
  district: string;
  weight: number;
}

const route: ApiRoutes = {
  method: ApiMethods.GET, //GET,DELETE su dung param
  // POST, PUT, PATCH su dung payload
  url: "address/getPriceAddress",
};
export const getShipFeeApi = async (
  payload: payloadGetShipFee
): Promise<ReturnResponse<any>> => {
  return Repository(route, payload);
};
