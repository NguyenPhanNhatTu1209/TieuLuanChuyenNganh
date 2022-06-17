import { ApiMethods, ApiRoutes } from "../defineApi";
import Repository from "../RepositoryApi";
import { ReturnListResponse } from "../Response";

export interface payloadGetStatisticOrder {
  timeStart: string;
  timeEnd: string;
}

const route: ApiRoutes = {
  method: ApiMethods.GET, //GET,DELETE su dung param
  // POST, PUT, PATCH su dung payload
  url: "statistic/getStatisticByOrderMobile",
};
export const getGetStatisticOrderApi = async (
  payload: payloadGetStatisticOrder
): Promise<ReturnListResponse<any>> => {
  return Repository(route, payload);
};
