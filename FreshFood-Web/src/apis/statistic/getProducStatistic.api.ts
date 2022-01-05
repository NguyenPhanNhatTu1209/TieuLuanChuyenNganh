import { ApiMethods, ApiRoutes } from "../defineApi";
import Repository from "../RepositoryApi";
import { ReturnListResponse } from "../Response";

const route: ApiRoutes = {
  method: ApiMethods.GET, //GET,DELETE su dung param
  // POST, PUT, PATCH su dung payload
  url: "statistic/getStatisticByProduct",
};
export const getProductStatisticApi = async (): Promise<
  ReturnListResponse<any>
> => {
  return Repository(route);
};
