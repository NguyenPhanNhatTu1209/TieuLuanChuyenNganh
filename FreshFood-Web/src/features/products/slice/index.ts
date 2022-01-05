import { createSlice, PayloadAction } from "@reduxjs/toolkit";
import { AddressStateTypes } from "../type";
import { getAllProductAsync, getDetailProductAsync } from "./thunk";

const initialState: Partial<AddressStateTypes> = {
  status: "idle",
  product: {},
  productDetail: {},
};

export const productSlice = createSlice({
  name: "Product",
  initialState,
  reducers: {
    getDetailProduct: (state, action: PayloadAction<any>) => {
      state.productDetail = action.payload;
    },
  },
  extraReducers: {
    [getAllProductAsync.pending.toString()]: (state) => {
      state.status = "loading";
    },
    [getAllProductAsync.fulfilled.toString()]: (
      state,
      action: PayloadAction<any>
    ) => {
      state.status = "idle";
      state.product = action.payload;
    },
    [getAllProductAsync.rejected.toString()]: (state, action) => {
      state.status = "idle";
    },
    [getDetailProductAsync.pending.toString()]: (state) => {
      state.status = "loading";
    },
    [getDetailProductAsync.fulfilled.toString()]: (
      state,
      action: PayloadAction<any>
    ) => {
      state.status = "idle";
      state.productDetail = action.payload;
    },
    [getDetailProductAsync.rejected.toString()]: (state, action) => {
      state.status = "idle";
    },
  },
});

export const { getDetailProduct } = productSlice.actions;
export default productSlice.reducer;
