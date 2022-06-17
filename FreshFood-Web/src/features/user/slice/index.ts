import { createSlice, PayloadAction } from "@reduxjs/toolkit";
import { UserStateTypes } from "../type";

const initialState: Partial<UserStateTypes> = {
  status: "idle",
  user: null,
};

export const userSlice = createSlice({
  name: "user",
  initialState,
  reducers: {
    getDetailUser: (state, action: PayloadAction<any>) => {
      state.user = action.payload;
    },
  },
  extraReducers: {},
});

export const { getDetailUser } = userSlice.actions;
export default userSlice.reducer;
