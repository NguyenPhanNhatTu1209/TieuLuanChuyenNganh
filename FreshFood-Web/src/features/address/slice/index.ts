import { createSlice, PayloadAction } from "@reduxjs/toolkit";
import { AddressStateTypes } from "../type";
import { getAllAddressAsync } from "./thunk";

const initialState: Partial<AddressStateTypes> = {
  status: "idle",
  addresses: [],
};

export const addressSlice = createSlice({
  name: "Auth",
  initialState,
  reducers: {},
  extraReducers: {
    [getAllAddressAsync.pending.toString()]: (state) => {
      state.status = "loading";
    },
    [getAllAddressAsync.fulfilled.toString()]: (
      state,
      action: PayloadAction<any>
    ) => {
      state.status = "idle";
      state.addresses = action.payload;
    },
    [getAllAddressAsync.rejected.toString()]: (state, action) => {
      state.status = "idle";
    },
  },
});

export default addressSlice.reducer;
