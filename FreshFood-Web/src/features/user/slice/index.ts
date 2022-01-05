import { createSlice, PayloadAction } from "@reduxjs/toolkit";
import { UserStateTypes } from "../type";
import { getAllUserAsync } from "./thunk";

const initialState: Partial<UserStateTypes> = {
  status: "idle",
  user: null,
  allUser: null,
};

export const userSlice = createSlice({
  name: "user",
  initialState,
  reducers: {
    getDetailUser: (state, action: PayloadAction<any>) => {
      state.user = action.payload;
    },
  },
  extraReducers: {
    [getAllUserAsync.pending.toString()]: (state) => {
      state.status = "loading";
    },
    [getAllUserAsync.fulfilled.toString()]: (
      state,
      action: PayloadAction<any>
    ) => {
      state.status = "idle";
      state.allUser = action.payload;
    },
    [getAllUserAsync.rejected.toString()]: (state, action) => {
      state.status = "idle";
    },
  },
});

export const { getDetailUser } = userSlice.actions;
export default userSlice.reducer;
