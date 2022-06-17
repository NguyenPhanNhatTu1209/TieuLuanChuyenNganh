import axiosClient from "../clientAxios";
import { ApiMethods, ApiRoutes } from "../defineApi";
import Repository from "../RepositoryApi";
import { ReturnResponse } from "../Response";

interface payloadUpdateAvatar {
  avatar: File;
}
const route: ApiRoutes = {
  method: ApiMethods.POST, //GET,DELETE su dung param
  // POST, PUT, PATCH su dung payload
  url: "product/updateProduct",
};
export const updateAvatarApi = async (
  payload: payloadUpdateAvatar
): Promise<ReturnResponse<any>> => {
  var bodyFormData = new FormData();
  bodyFormData.append("image", payload.avatar);

  return axiosClient.post("user/updateImage", bodyFormData, {
    headers: {
      "Content-Type": "multipart/form-data",
    },
  });
};
