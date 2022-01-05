import { ApiMethods } from "../defineApi";
import Repository from "../RepositoryApi";
import { ReturnListResponse } from "../Response";

export interface payloadGetAllUser {
  skip: number;
  limit: number;
  role: number;
}

const route = {
  method: ApiMethods.GET,
  url: "user/getAllUser",
};
export const getAllUserApi = async (
  payload: payloadGetAllUser
): Promise<ReturnListResponse<any>> => {
  return Repository(route, payload);
};
