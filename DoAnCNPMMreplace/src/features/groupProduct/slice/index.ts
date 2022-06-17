import { createSlice, PayloadAction } from "@reduxjs/toolkit";
import { GroupProductStateTypes } from "../type";
import { getAllGroupProductAsync } from "./thunk";

const initialState: Partial<GroupProductStateTypes> = {
  status: "idle",
  groupProducts: [],
};

export const addressSlice = createSlice({
  name: "Auth",
  initialState,
  reducers: {},
  extraReducers: {
    [getAllGroupProductAsync.pending.toString()]: (state) => {
      state.status = "loading";
    },
    [getAllGroupProductAsync.fulfilled.toString()]: (
      state,
      action: PayloadAction<any>
    ) => {
      state.status = "idle";
      state.groupProducts = action.payload;
    },
    [getAllGroupProductAsync.rejected.toString()]: (state, action) => {
      state.status = "idle";
    },
  },
});

export default addressSlice.reducer;
