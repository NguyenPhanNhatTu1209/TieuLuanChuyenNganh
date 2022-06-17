import { createAsyncThunk } from "@reduxjs/toolkit";
import { getInfoApi } from "../../../apis/auths/getInfo.api";
import { loginAsync, payloadlogin } from "../../../apis/auths/login.api";

export const getCurrentUserAsync = createAsyncThunk(
  "Auth/getCurrentUser",
  async (): Promise<any> => {
    const response = await getInfoApi();
    return response.data;
  }
);

export const userLoginAsync = createAsyncThunk(
  "Auth/userLogin",
  async (payload: payloadlogin): Promise<any> => {
    const response = await loginAsync(payload);
    return response;
  }
);
