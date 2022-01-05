import { ApiMethods, ApiRoutes } from "../defineApi";
import Repository from "../RepositoryApi";
import { ReturnResponse } from "../Response";

interface payloadCreateGroupProduct {
  name: string;
}
const route: ApiRoutes = {
  method: ApiMethods.POST, //GET,DELETE su dung param
  // POST, PUT, PATCH su dung payload
  url: "groupProduct/createGroupProduct",
};
export const createGroupProductApi = async (
  payload: payloadCreateGroupProduct
): Promise<ReturnResponse<any>> => {
  return Repository(route, payload);
};
