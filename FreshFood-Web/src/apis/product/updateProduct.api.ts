import axiosClient from "../clientAxios";
import { ApiMethods, ApiRoutes } from "../defineApi";
import { ReturnResponse } from "../Response";

interface payloadUpdateProduct {
  name: string;
  detail: string;
  price: string;
  groupProduct: string;
  weight: string;
  quantity: string;
  id: string;
  image: Array<File>;
}
const route: ApiRoutes = {
  method: ApiMethods.PUT, //GET,DELETE su dung param
  // POST, PUT, PATCH su dung payload
  url: "product/updateProduct",
};
export const updateProductApi = async (
  payload: payloadUpdateProduct
): Promise<ReturnResponse<any>> => {
  var bodyFormData = new FormData();
  bodyFormData.append("name", payload.name);
  bodyFormData.append("detail", payload.detail);
  bodyFormData.append("price", payload.price);
  bodyFormData.append("groupProduct", payload.groupProduct);
  bodyFormData.append("weight", payload.weight);
  bodyFormData.append("quantity", payload.quantity);
  bodyFormData.append("id", payload.id);
  for (let i = 0; i < payload.image.length; i++) {
    bodyFormData.append("image", payload.image[i]);
  }
  return axiosClient.put("product/updateProduct", bodyFormData, {
    headers: {
      "Content-Type": "multipart/form-data",
    },
  });
};
