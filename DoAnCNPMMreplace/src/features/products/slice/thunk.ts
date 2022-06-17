import { createAsyncThunk } from "@reduxjs/toolkit";
import {
  getAllProductApi,
  payloadGetAllProduct,
} from "../../../apis/product/getallproduct.api";
import { getDetailProductApi } from "../../../apis/product/getdetailproduct.api";

export const getAllProductAsync = createAsyncThunk(
  "Product/getAllProduct",
  async (payload: payloadGetAllProduct): Promise<any> => {
    const response = await getAllProductApi(payload);
    return response;
  }
);

export const getDetailProductAsync = createAsyncThunk(
  "Product/getDetailProduct",
  async (payload: { id: string }): Promise<any> => {
    const response = await getDetailProductApi(payload);
    return response;
  }
);
