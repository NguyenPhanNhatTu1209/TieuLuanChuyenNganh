import { createAsyncThunk } from "@reduxjs/toolkit";
import { getAllAddressApi } from "../../../apis/address/getallddress.api";
import { getAllGroupProductApi } from "../../../apis/groupProduct/getAllGroupProduct.api";

export const getAllGroupProductAsync = createAsyncThunk(
  "groupProduct/getAllGroupProduct",
  async (): Promise<any> => {
    const response = await getAllGroupProductApi();
    return response.data;
  }
);
