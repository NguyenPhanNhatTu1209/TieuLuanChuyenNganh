import { createSlice, PayloadAction } from "@reduxjs/toolkit";
import { AddressStateTypes } from "../type";
import { getAllChartAsync } from "./thunk";

const initialState: Partial<AddressStateTypes> = {
  status: "idle",
  chart: [],
};

export const statisticSlice = createSlice({
  name: "Auth",
  initialState,
  reducers: {},
  extraReducers: {
    [getAllChartAsync.pending.toString()]: (state) => {
      state.status = "loading";
    },
    [getAllChartAsync.fulfilled.toString()]: (
      state,
      action: PayloadAction<any>
    ) => {
      state.status = "idle";
      state.chart = action.payload;
    },
    [getAllChartAsync.rejected.toString()]: (state, action) => {
      state.status = "idle";
    },
  },
});

export default statisticSlice.reducer;
