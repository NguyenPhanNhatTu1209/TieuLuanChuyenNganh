import { ApiMethods, ApiRoutes } from "../defineApi";
import Repository from "../RepositoryApi";
import { ReturnResponse } from "../Response";

const route: ApiRoutes = {
  method: ApiMethods.GET, //GET,DELETE su dung param
  // POST, PUT, PATCH su dung payload
  url: "groupProduct/getAllGroupProduct",
};
export const getAllGroupProductApi = async (): Promise<ReturnResponse<any>> => {
  return Repository(route);
};
