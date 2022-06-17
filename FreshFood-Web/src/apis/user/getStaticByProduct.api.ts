import { ApiMethods } from "../defineApi";
import Repository from "../RepositoryApi";

const route = {
  method: ApiMethods.GET,
  url: "statistic/getStatisticByProduct",
};
export const getStaticByProductApi = async () => {
  return Repository(route);
};
