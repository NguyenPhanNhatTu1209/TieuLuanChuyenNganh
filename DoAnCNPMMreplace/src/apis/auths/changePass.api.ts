import { ApiMethods, ApiRoutes } from "../defineApi";
import Repository from "../RepositoryApi";
import { ReturnResponse } from "../Response";

interface payloadChangPass {
  oldPassword: string;
  newPassword: string;
}
const route: ApiRoutes = {
  method: ApiMethods.POST, //GET,DELETE su dung param
  // POST, PUT, PATCH su dung payload
  url: "user/changePassword",
};
export const changePassAsync = async (
  payload: payloadChangPass
): Promise<ReturnResponse<any>> => {
  return Repository(route, payload);
};
