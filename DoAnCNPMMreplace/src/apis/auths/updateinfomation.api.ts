import { loginModel } from "../../models/auth.model";
import { ApiMethods, ApiRoutes } from "../defineApi";
import Repository from "../RepositoryApi";
import { ReturnResponse } from "../Response";

export interface payloadUpdateInfomation {
  phone: string;
  name: string;
}
const route: ApiRoutes = {
  method: ApiMethods.PUT, //GET,DELETE su dung param
  // POST, PUT, PATCH su dung payload
  url: "user/updateInformation",
};
export const updateInfomatinApi = async (
  payload: payloadUpdateInfomation
): Promise<ReturnResponse<any>> => {
  return Repository(route, payload);
};
