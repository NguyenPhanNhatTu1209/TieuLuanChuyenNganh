import { createAsyncThunk } from "@reduxjs/toolkit";
import {
  getAllProductApi,
  payloadGetAllProduct,
} from "../../../apis/product/getallproduct.api";

export const getAllProductAsync = createAsyncThunk(
  "Product/getAllProduct",
  async (payload: payloadGetAllProduct): Promise<any> => {
    const response = await getAllProductApi(payload);
    return response.data;
  }
);
