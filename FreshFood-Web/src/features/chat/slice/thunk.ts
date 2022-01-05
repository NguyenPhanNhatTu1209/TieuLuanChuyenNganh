import { createAsyncThunk } from "@reduxjs/toolkit";
import { getChatRoomApi } from "../../../apis/chat/getChatRoom.api";
import {
  getMessageApi,
  payloadGetMessage,
} from "../../../apis/chat/getMessage.api";

export const getAllMessageAsync = createAsyncThunk(
  "chat/getAllMessage",
  async (payload: payloadGetMessage): Promise<any> => {
    const response = await getMessageApi(payload);
    return response.data;
  }
);

export const getAllRoomAsync = createAsyncThunk(
  "chat/getAllRoom",
  async (): Promise<any> => {
    const response = await getChatRoomApi();
    return response.data;
  }
);
