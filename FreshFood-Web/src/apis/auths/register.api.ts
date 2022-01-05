import { registerModel } from "../../models/auth.model";
import { ApiMethods, ApiRoutes } from "../defineApi";
import Repository from "../RepositoryApi";
import { ReturnResponse } from "../Response";

interface payloadRegister {
  email: string;
  password: string;
  phone: string;
  name: string;
  address: string;
}
const route: ApiRoutes = {
  method: ApiMethods.POST, //GET,DELETE su dung param
  // POST, PUT, PATCH su dung payload
  url: "user/register",
};
export const registerAsync = async (
  payload: payloadRegister
): Promise<ReturnResponse<registerModel>> => {
  return Repository(route, payload);
};
