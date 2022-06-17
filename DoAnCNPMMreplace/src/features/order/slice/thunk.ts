import { createAsyncThunk } from "@reduxjs/toolkit";
import { getAllAddressApi } from "../../../apis/address/getallddress.api";
import {
  getGetAllOrderApi,
  payloadGetAllOrder,
} from "../../../apis/order/getAllOrder.api";

export const getAllAddressAsync = createAsyncThunk(
  "Address/getAllAddress",
  async (): Promise<any> => {
    const response = await getAllAddressApi();
    return response.data;
  }
);
export const getAllOrderAsync = createAsyncThunk(
  "Order/getAllOrderAsync",
  async (payload: payloadGetAllOrder): Promise<any> => {
    const response = await getGetAllOrderApi(payload);
    return response.data;
  }
);
