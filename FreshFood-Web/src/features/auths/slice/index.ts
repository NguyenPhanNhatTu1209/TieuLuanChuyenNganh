import { createSlice, PayloadAction } from "@reduxjs/toolkit";
import { notifyError, notifySuccess } from "../../../utils/notify";
import { AuthStateTypes } from "../type";
import { getCurrentUserAsync, userLoginAsync } from "./thunk";

const initialState: Partial<AuthStateTypes> = {
  user: null,
  status: "idle",
};

export const authSlice = createSlice({
  name: "Auth",
  initialState,
  reducers: {
    changeUser: (state, action: PayloadAction<any>) => {
      state.user = { ...state.user, avatar: action.payload.image };
    },
    logoutUser: (state) => {
      state.user = null;
      localStorage.removeItem("token");
      notifySuccess("Logout Successfully");
    },
  },
  extraReducers: {
    [getCurrentUserAsync.pending.toString()]: (state) => {
      state.status = "loading";
    },
    [getCurrentUserAsync.fulfilled.toString()]: (
      state,
      action: PayloadAction<any>
    ) => {
      state.status = "idle";
      state.user = action.payload;
    },
    [getCurrentUserAsync.rejected.toString()]: (state, action) => {
      state.status = "idle";
    },
    [userLoginAsync.pending.toString()]: (state) => {
      state.status = "loading";
    },
    [userLoginAsync.fulfilled.toString()]: (
      state,
      action: PayloadAction<any>
    ) => {
      state.status = "idle";
      const data = action.payload;
      if (data.statusCode === 200) {
        if (data.data.token) {
          localStorage.setItem("token", data.data.token);
          notifySuccess(data.message);
        }
      } else {
        notifyError(data.message);
      }
    },
    [userLoginAsync.rejected.toString()]: (state) => {
      state.status = "idle";
    },
  },
});

export const { logoutUser, changeUser } = authSlice.actions;
export default authSlice.reducer;
