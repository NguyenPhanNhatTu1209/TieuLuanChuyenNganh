import { ApiMethods, ApiRoutes } from "../defineApi";
import Repository from "../RepositoryApi";
import { ReturnListResponse, ReturnResponse } from "../Response";

const route: ApiRoutes = {
  method: ApiMethods.GET, //GET,DELETE su dung param
  // POST, PUT, PATCH su dung payload
  url: "product/getProductRecommend",
};
export const getProductReccomendAsync = async (): Promise<
  ReturnListResponse<any>
> => {
  return Repository(route);
};
