import axios from "axios";
import { loginModel } from "../../models/auth.model";
import axiosClient from "../clientAxios";
import { ApiMethods, ApiRoutes } from "../defineApi";
import Repository from "../RepositoryApi";
import { ReturnResponse } from "../Response";

export interface payloadCreateProduct {
  name: string;
  detail: string;
  price: string;
  groupProduct: string;
  weight: string;
  quantity: string;
  image: Array<File>;
}
const route: ApiRoutes = {
  method: ApiMethods.POST, //GET,DELETE su dung param
  // POST, PUT, PATCH su dung payload
  url: "product/createProduct",
};
export const createProductApi = async (
  payload: payloadCreateProduct
): Promise<ReturnResponse<any>> => {
  var bodyFormData = new FormData();
  bodyFormData.append("name", payload.name);
  bodyFormData.append("detail", payload.detail);
  bodyFormData.append("price", payload.price);
  bodyFormData.append("groupProduct", payload.groupProduct);
  bodyFormData.append("weight", payload.weight);
  bodyFormData.append("quantity", payload.quantity);
  for (let i = 0; i < payload.image.length; i++) {
    bodyFormData.append("image", payload.image[i]);
  }

  return axiosClient.post("product/createProduct", bodyFormData, {
    headers: {
      "Content-Type": "multipart/form-data",
    },
  });
};
