import { createSlice, PayloadAction } from "@reduxjs/toolkit";
import { OrderStateTypes } from "../type";
import { getAllAddressAsync, getAllOrderAsync } from "./thunk";

const initialState: Partial<OrderStateTypes> = {
  status: "idle",
  order: {},
  listOrder: [],
};

export const orderSlice = createSlice({
  name: "Order",
  initialState,
  reducers: {
    getDetailOrder: (state, action: PayloadAction<any>) => {
      state.order = action.payload;
    },
  },
  extraReducers: {
    [getAllOrderAsync.pending.toString()]: (state) => {
      state.status = "loading";
    },
    [getAllOrderAsync.fulfilled.toString()]: (
      state,
      action: PayloadAction<any>
    ) => {
      state.status = "idle";
      state.listOrder = action.payload;
    },
    [getAllOrderAsync.rejected.toString()]: (state, action) => {
      state.status = "idle";
    },
  },
});

export default orderSlice.reducer;
export const { getDetailOrder } = orderSlice.actions;
