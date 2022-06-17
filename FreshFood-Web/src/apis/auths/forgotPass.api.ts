import { ApiMethods, ApiRoutes } from "../defineApi";
import Repository from "../RepositoryApi";
import { ReturnListResponse } from "../Response";

interface payloadForgotPass {
  email: string;
}

const route: ApiRoutes = {
  method: ApiMethods.GET, //GET,DELETE su dung param
  // POST, PUT, PATCH su dung payload
  url: "user/forgotPassword",
};
export const forgotPassAsync = async (
  payload: payloadForgotPass
): Promise<ReturnListResponse<any>> => {
  return Repository(route, payload);
};
