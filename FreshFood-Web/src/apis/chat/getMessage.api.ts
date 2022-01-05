import { ApiMethods } from "../defineApi";
import Repository from "../RepositoryApi";
import { ReturnListResponse } from "../Response";

export interface payloadGetMessage {
  idRoom: string;
  skip: number;
  limit: number;
}

const route = {
  method: ApiMethods.GET,
  url: "chat/getMessage",
};
export const getMessageApi = async (
  payload: payloadGetMessage
): Promise<ReturnListResponse<any>> => {
  return Repository(route, payload);
};
