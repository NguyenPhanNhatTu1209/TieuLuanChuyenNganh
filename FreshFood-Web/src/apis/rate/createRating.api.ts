import { ApiMethods, ApiRoutes } from "../defineApi";
import Repository from "../RepositoryApi";
import { ReturnResponse } from "../Response";

interface payloadCreateRating {
  star: string;
  content: string;
  productID: string;
  orderID: string;
}
const route: ApiRoutes = {
  method: ApiMethods.POST, //GET,DELETE su dung param
  // POST, PUT, PATCH su dung payload
  url: "eveluate/createEveluate",
};
export const createRatingApi = async (
  payload: Array<payloadCreateRating>
): Promise<ReturnResponse<any>> => {
  return Repository(route, payload);
};
