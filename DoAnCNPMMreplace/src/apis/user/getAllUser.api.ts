import { ApiMethods } from "../defineApi";
import Repository from "../RepositoryApi";

const route = {
  method: ApiMethods.GET,
  url: "user/getAllUser",
};
export const getAllUserApi = async () => {
  return Repository(route);
};
