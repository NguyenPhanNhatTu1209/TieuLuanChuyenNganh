import { loginModel } from "../../models/auth.model";
import { ApiMethods, ApiRoutes } from "../defineApi";
import Repository from "../RepositoryApi";
import { ReturnResponse } from "../Response";

const route: ApiRoutes = {
  method: ApiMethods.GET,
  url: "user/getInformation",
};
export const getInfoApi = async (): Promise<ReturnResponse<any>> => {
  return Repository(route);
};
